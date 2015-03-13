package Gameplay.Player 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Gameplay.Level.RoomManager;
	import Menu.PlayerSelection.PlayerInformation;
	import Utils.InputContent.Controllers.ControllerInput;
	import Utils.InputContent.Controllers.GameController;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerHandler extends Sprite
	{	
		private var m_Players:Vector.<Player>;
		
		private var m_StartBounds:Rectangle;
		
		public function PlayerHandler() 
		{
			m_Players = new Vector.<Player>();
			
			m_StartBounds = new Rectangle(0, 0, 0, 0);
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
				player.SetPosition(spawnPlayer(player.Size));
				this.addChild(player);
			}
		}
		
		private function spawnPlayer(playerSize:Point):Point
		{
			var screenPosition:Point = new Point(0, 0);
			
			screenPosition.x = UtilMethods.Random(m_StartBounds.x + RoomManager.RoomOffset.x * 0.5, m_StartBounds.x + m_StartBounds.width - playerSize.x);
			screenPosition.y = UtilMethods.Random(m_StartBounds.y + RoomManager.RoomOffset.y * 0.5, m_StartBounds.y + m_StartBounds.height - playerSize.y);
			
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
		
		public function SetStartBounds(startBounds:Rectangle):void
		{
			m_StartBounds = new Rectangle(startBounds.x, startBounds.y, startBounds.width, startBounds.height);
		}
	}
}