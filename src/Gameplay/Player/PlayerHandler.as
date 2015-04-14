package Gameplay.Player 
{
	import Classes.ClassTypes;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Gameplay.Level.Events.RoomEvent;
	import Gameplay.Level.RoomManager;
	import Gameplay.Player.Events.SpawnPlayersEvent;
	import Gameplay.State_Gameplay;
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
			State_Gameplay.eventDispatcher.addEventListener(SpawnPlayersEvent.SPAWN_PLAYERS_EVENT, eh_SpawnPlayers);
		}
		
		public function Update():void
		{
			for each(var player:Player in m_Players)
			{
				player.Update();
			}
			
			checkPlayersAtExit();
		}
		
		public function Begin():void
		{
			createPlayers();
		}
		
		public function Leave():void
		{
			removePlayers();
		}
		
		private function eh_SpawnPlayers(evt:SpawnPlayersEvent):void
		{
			for each(var player:Player in m_Players)
			{
				var randomIndex:int = UtilMethods.Random(0, evt.E_SpawnPoints.length - 1, UtilMethods.ROUND);
				var spawnPosition:Point = new Point(evt.E_SpawnPoints[randomIndex].x, evt.E_SpawnPoints[randomIndex].y);
				player.SetPosition(spawnPosition);
				player.Spawned = true;
				player.SetBoundsPosition(evt.E_RoomPosition);
			}
		}
		
		private function checkPlayersAtExit():void
		{
			var exit:int = m_Players[0].Exit;
			
			for each(var player:Player in m_Players)
			{
				if (player.Exit != exit || player.Spawned)
				{
					exit = -1;
				}
			}
			
			if (exit != -1)
			{
				State_Gameplay.eventDispatcher.dispatchEvent(new RoomEvent(RoomEvent.CHANGE_ROOM_EVENT, exit));
			}
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
			
			screenPosition.x = UtilMethods.Random(m_StartBounds.x + RoomManager.ROOM_OFFSET.x * 0.5, m_StartBounds.x + m_StartBounds.width - playerSize.x);
			screenPosition.y = UtilMethods.Random(m_StartBounds.y + RoomManager.ROOM_OFFSET.y * 0.5, m_StartBounds.y + m_StartBounds.height - playerSize.y);
			
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
					var player:Player = ClassTypes.GetClassInstance(playerInfo.ClassType);
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