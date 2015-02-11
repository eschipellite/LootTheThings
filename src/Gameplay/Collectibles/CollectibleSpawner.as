package Gameplay.Collectibles 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Gameplay.HUD.Events.ScoreEvent;
	import Gameplay.Player.Events.PlayerCollisionEvent;
	import Gameplay.State_Gameplay;
	import Utils.GameTime;
	import Utils.ImageContent.Image;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class CollectibleSpawner extends Sprite
	{
		private var m_Collectibles:Vector.<Star>;
		
		private var m_ScoreAward:int = 5;
		
		private var m_RandomSpawnMin:Number = 2;
		private var m_RandomSpawnMax:Number = 5;
		
		private var m_CurrentSpawnTime:Number;
		
		public function CollectibleSpawner() 
		{
			m_Collectibles = new Vector.<Star>();
			
			m_CurrentSpawnTime = 0;
		}	
		
		public function Initialize():void
		{
			
		}
		
		public function InitializeEventListeners():void
		{
			State_Gameplay.eventDispatcher.addEventListener(PlayerCollisionEvent.CHECK_COLLECTIBLE_COLLISION_EVENT, eh_CheckCollisionWithPlayer);
		}
		
		public function Begin():void
		{
			m_CurrentSpawnTime = getRandomSpawnTime();
			
			spawnCollectible(true);
		}
		
		public function Leave():void
		{
			for each(var collectible:Star in m_Collectibles)
			{
				if (this.contains(collectible))
				{
					this.removeChild(collectible);
				}
			}
			
			m_Collectibles = new Vector.<Star>();
		}
		
		public function Update():void
		{
			checkRandomSpawn();
		}
		
		private function checkRandomSpawn():void
		{
			m_CurrentSpawnTime -= GameTime.ElapsedGameTimeSeconds;
			
			if (m_CurrentSpawnTime <= 0)
			{
				spawnCollectible(false);
				
				m_CurrentSpawnTime = getRandomSpawnTime();
			}
		}
		
		private function eh_CheckCollisionWithPlayer(evt:PlayerCollisionEvent):void
		{
			for (var index:int = 0; index < m_Collectibles.length; index++)
			{
				if (m_Collectibles[index].CollisionBounds.intersects(evt.E_Player.CollisionBounds))
				{
					State_Gameplay.eventDispatcher.dispatchEvent(new ScoreEvent(ScoreEvent.ADJUST_SCORE_EVENT, evt.E_Player.Index, m_ScoreAward));
					
					if (m_Collectibles[index].ShouldRespawn)
					{
						m_Collectibles[index].SetPosition(getRandomCollectibleSpawnPosition(m_Collectibles[index].Size));
					}
					else
					{
						removeCollectible(index);
					}
				}
			}
		}
		
		private function removeCollectible(index:int):void
		{
			if (this.contains(m_Collectibles[index]))
			{
				this.removeChild(m_Collectibles[index]);
				m_Collectibles.splice(index, 1);
			}
		}
		
		private function getRandomCollectibleSpawnPosition(collectibleSize:Point):Point
		{
			var screenPosition:Point = new Point(0, 0);
			
			screenPosition.x = UtilMethods.RandomRange(0, Main.ScreenArea.x - collectibleSize.x);
			screenPosition.y = UtilMethods.RandomRange(0, Main.ScreenArea.y - collectibleSize.y);
			
			return screenPosition;
		}
		
		private function getRandomSpawnTime():Number
		{
			return UtilMethods.RandomRange(m_RandomSpawnMin, m_RandomSpawnMax);
		}
		
		private function spawnCollectible(shouldRespawn:Boolean):void
		{
			var collectible:Star = new Star();
			collectible.Initialize(shouldRespawn);
			collectible.SetPosition(getRandomCollectibleSpawnPosition(collectible.Size));
			
			this.addChild(collectible);
			
			m_Collectibles.push(collectible);
		}
	}
}