package Gameplay 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import Gameplay.HUD.GameHUD;
	import General.States.GameState;
	import Menu.PlayerSelection.Events.PlayerInformationEvent;
	import Menu.PlayerSelection.State_PlayerSelection;
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class State_Gameplay extends GameState
	{		
		public static const TILE_SIZE:int = 64;
		public static const INVERT_TILE_SIZE:Number = 1 / 64;
		
		private static var g_eventDispatcher:IEventDispatcher = new EventDispatcher();
		
		private var m_GameHUD:GameHUD;
		private var m_GameApp:GameApp;
		
		public function State_Gameplay() 
		{
			m_GameHUD = new GameHUD();
			m_GameApp = new GameApp();
		}
		
		public override function Initialize():void
		{
			m_GameHUD.Initialize();
			m_GameApp.Initialize();
			
			this.addChild(m_GameApp);
			this.addChild(m_GameHUD);
		}
		
		public override function InitializeEventListeners():void
		{
			State_PlayerSelection.eventDispatcher.addEventListener(PlayerInformationEvent.SEND_PLAYER_INFORMATION_EVENT, eh_SetPlayerInformation);
			
			m_GameHUD.InitializeEventListeners();
			m_GameApp.InitializeEventListeners();
		}
		
		public override function Update():void
		{
			m_GameApp.Update();
			m_GameHUD.Update();
		}
		
		public override function Begin():void
		{
			m_GameHUD.Begin();
			m_GameApp.Begin();
		}
		
		public override function Leave():void
		{
			m_GameHUD.Leave();
			m_GameApp.Leave();
		}
		
		private function eh_SetPlayerInformation(evt:PlayerInformationEvent):void
		{
			m_GameHUD.SetPlayerInformation(evt.E_PlayerInformation);
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return g_eventDispatcher;
		}
	}
}