package Gameplay.Enemy 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Gameplay.Enemy.Events.SpawnEnemiesEvent;
	import Gameplay.Level.Events.PlayerCollisionEvent;
	import Gameplay.Level.Room;
	import Gameplay.Level.RoomManager;
	import Gameplay.Level.Tiles.TileValues;
	import Gameplay.Level.Waves.Wave;
	import Gameplay.Level.Waves.WaveInfo;
	import Gameplay.State_Gameplay;
	import Utils.GameTime;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class EnemyManager extends Sprite
	{
		private var m_WaveInfo:WaveInfo;
		private var m_CurrentWaveTime:Number;
		
		private var m_Enemies:Vector.<Enemy>;
		
		public function EnemyManager() 
		{
			m_WaveInfo = new WaveInfo();
			m_Enemies = new Vector.<Enemy>();
		}
		
		public function Initialize():void
		{
		}
		
		public function InitializeEventListeners():void
		{
			State_Gameplay.eventDispatcher.addEventListener(SpawnEnemiesEvent.SPAWN_ENEMIES_EVENT, eh_SpawnEnemiesEvent);
			State_Gameplay.eventDispatcher.addEventListener(PlayerCollisionEvent.CHECK_PLAYER_COLLISION_WITH_ENEMIES_EVENT, eh_CheckPlayerCollision);
		}
		
		private function eh_CheckPlayerCollision(evt:PlayerCollisionEvent):void
		{
			for each(var enemy:Enemy in m_Enemies)
			{
				enemy.CheckPlayerCollision(evt.E_Player);
			}
		}
		
		public function Update():void
		{
			updateEnemies();
			
			checkWave();
		}
		
		private function checkWave():void
		{
			if (m_WaveInfo.Active)
			{
				m_CurrentWaveTime += GameTime.ElapsedGameTimeSeconds;
				
				if (m_CurrentWaveTime >= m_WaveInfo.CurrentDuration)
				{
					m_CurrentWaveTime = 0;
					m_WaveInfo.IncrementWave();
					
					if (m_WaveInfo.Active)
					{
						spawnEnemies();
					}
				}
			}
		}
		
		public function Begin():void
		{
		}
		
		public function Leave():void
		{
			reset();
		}
		
		private function reset():void
		{
			for each(var enemy:Enemy in m_Enemies)
			{
				this.removeChild(enemy);
			}
			
			m_Enemies = new Vector.<Enemy>();
		}
		
		private function eh_SpawnEnemiesEvent(evt:SpawnEnemiesEvent):void
		{	
			reset();
			
			m_WaveInfo = evt.E_WaveInfo;
			m_WaveInfo.Reset();
			m_CurrentWaveTime = 0;
			
			spawnEnemies();
		}
		
		private function spawnEnemies():void
		{
			for (var index:int = 0; index < m_WaveInfo.CurrentEnemies; index++)
			{
				var enemy:Enemy = new Enemy();
				enemy.Initialize(RoomManager.CurrentRoom.GridPosition, RoomManager.CurrentRoom.Size);
				
				var gridPosition:Point = m_WaveInfo.GetRandomGridSpawnLocation();
				var worldPosition:Point = RoomManager.CurrentTileGrid.ConvertGridToWorld(gridPosition);
				enemy.x = worldPosition.x;
				enemy.y = worldPosition.y;
				
				this.addChild(enemy);
				m_Enemies.push(enemy);
			}
		}
		
		private function updateEnemies():void
		{
			RoomManager.CurrentTileGrid.RefreshPathing();
			
			for each(var enemy:Enemy in m_Enemies)
			{
				enemy.Update();
			}
		}
	}
}