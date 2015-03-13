package Gameplay 
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import Gameplay.HUD.GameHUD;
	import Gameplay.Level.RoomManager;
	import Gameplay.Player.Player;
	import Gameplay.Player.PlayerHandler;
	import General.Camera;
	import General.States.GameState;
	import Menu.PlayerSelection.Events.PlayerInformationEvent;
	import Menu.PlayerSelection.State_PlayerSelection;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class State_Gameplay extends GameState
	{		
		private static var g_eventDispatcher:IEventDispatcher = new EventDispatcher();
		
		private var m_GameHUD:GameHUD;
		private var m_PlayerHandler:PlayerHandler;
		private var m_RoomManager:RoomManager;
		
		public function State_Gameplay() 
		{
			m_GameHUD = new GameHUD();
			m_PlayerHandler = new PlayerHandler();
			m_RoomManager = new RoomManager();
		}
		
		public override function Initialize():void
		{
			m_GameHUD.Initialize();
			m_PlayerHandler.Initialize();
			m_RoomManager.Initialize();
			
			this.addChild(m_RoomManager);
			this.addChild(m_PlayerHandler);
			this.addChild(m_GameHUD);
		}
		
		public override function InitializeEventListeners():void
		{
			State_PlayerSelection.eventDispatcher.addEventListener(PlayerInformationEvent.SEND_PLAYER_INFORMATION_EVENT, eh_GetPlayerInformation);
			
			m_GameHUD.InitializeEventListeners();
			m_PlayerHandler.InitializeEventListeners();
			m_RoomManager.InitializeEventListeners();
		}
		
		public override function Update():void
		{
			m_GameHUD.Update();
			m_PlayerHandler.Update();
			m_RoomManager.Update();
		}
		
		public override function Begin():void
		{
			m_PlayerHandler.SetStartBounds(m_RoomManager.StartBounds);
			
			m_GameHUD.Begin();
			m_PlayerHandler.Begin();
			m_RoomManager.Begin();
		}
		
		public override function Leave():void
		{
			m_GameHUD.Leave();
			m_PlayerHandler.Leave();
			m_RoomManager.Leave();
		}
		
		private function eh_GetPlayerInformation(evt:PlayerInformationEvent):void
		{
			m_GameHUD.SetPlayerInformation(evt.E_PlayerInformation);
			m_PlayerHandler.SetPlayerInformation(evt.E_PlayerInformation);
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return g_eventDispatcher;
		}
	}
}