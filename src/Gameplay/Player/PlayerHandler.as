package Gameplay.Player 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Menu.PlayerSelection.PlayerInformation;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerHandler extends Sprite
	{	
		private var m_Players:Vector.<Player>;
		
		public function PlayerHandler() 
		{
			m_Players = new Vector.<Player>();
		}
		
		public function Initialize():void
		{
		}
		
		public function InitializeEventListeners():void
		{
			
		}
		
		public function Update():void
		{
			for each(var player:Player in m_Players)
			{
				player.Update();
			}
		}
		
		public function Begin():void
		{
			createPlayers();
		}
		
		public function Leave():void
		{
			removePlayers();
		}
		
		private function createPlayers():void
		{
			for each(var player:Player in m_Players)
			{
				player.SetPosition(getRandomPlayerPosition(player.Size));
				this.addChild(player);
			}
		}
		
		private function getRandomPlayerPosition(playerSize:Point):Point
		{
			var screenPosition:Point = new Point(0, 0);
			
			screenPosition.x = UtilMethods.RandomRange(0, Main.ScreenArea.x - playerSize.x);
			screenPosition.y = UtilMethods.RandomRange(0, Main.ScreenArea.y - playerSize.y);
			
			return screenPosition;
		}
		
		private function removePlayers():void
		{
			for each(var player:Player in m_Players)
			{
				if (this.contains(player))
				{
					this.removeChild(player);
				}
			}
			
			m_Players = new Vector.<Player>();
		}
		
		public function SetPlayerInformation(playerInformation:Vector.<PlayerInformation>):void
		{
			removePlayers();
			
			for each(var playerInfo:PlayerInformation in playerInformation)
			{
				if (playerInfo.InGame)
				{
					var player:Player = new Player();
					player.Initialize(playerInfo.Index);
					m_Players.push(player);
				}
			}
		}
	}
}