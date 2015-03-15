package Gameplay 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Gameplay.Level.RoomManager;
	import Gameplay.Player.PlayerHandler;
	import General.Camera;
	import Menu.PlayerSelection.Events.PlayerInformationEvent;
	import Menu.PlayerSelection.State_PlayerSelection;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class GameApp extends Sprite
	{
		private var m_PlayerHandler:PlayerHandler;
		private var m_RoomManager:RoomManager;
		
		public function GameApp() 
		{
			m_PlayerHandler = new PlayerHandler();
			m_RoomManager = new RoomManager();
		}
		
		public function Initialize():void
		{
			m_PlayerHandler.Initialize();
			m_RoomManager.Initialize();
			
			Camera.SetSource(this, Main.ScreenArea);
			Camera.SetCameraMin(new Point( -10000, -10000));
			Camera.SetWorldSize(new Point(100000, 100000));
			
			this.addChild(m_RoomManager);
			this.addChild(m_PlayerHandler);
		}
		
		public function InitializeEventListeners():void
		{
			State_PlayerSelection.eventDispatcher.addEventListener(PlayerInformationEvent.SEND_PLAYER_INFORMATION_EVENT, eh_SetPlayerInformation);
			
			m_PlayerHandler.InitializeEventListeners();
			m_RoomManager.InitializeEventListeners();
		}
		
		private function eh_SetPlayerInformation(evt:PlayerInformationEvent):void
		{
			m_PlayerHandler.SetPlayerInformation(evt.E_PlayerInformation);
		}
		
		public function Update():void
		{
			m_PlayerHandler.Update();
			m_RoomManager.Update();
		}
		
		public function Begin():void
		{
			Camera.SetPosition(new Point(0, 0));
			
			m_PlayerHandler.SetStartBounds(m_RoomManager.StartBounds);
			m_PlayerHandler.Begin();
			m_RoomManager.Begin();
		}
		
		public function Leave():void
		{
			m_PlayerHandler.Leave();
			m_RoomManager.Leave();
		}
	}
}