package Gameplay 
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import Gameplay.HUD.GameHUD;
	import Gameplay.Player.Player;
	import Gameplay.Player.PlayerHandler;
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
		
		private var m_Background:Image;
		
		private var m_PlayerHandler:PlayerHandler;
		
		private var m_GameHUD:GameHUD;
		
		public function State_Gameplay() 
		{
			m_PlayerHandler = new PlayerHandler();
			m_GameHUD = new GameHUD();
		}
		
		public override function Initialize():void
		{
			m_Background = ImageLoader.GetImage(EmbeddedImages_Gameplay.Gameplay_Background);
			
			m_PlayerHandler.Initialize();
			m_GameHUD.Initialize();
			
			this.addChild(m_Background);
			this.addChild(m_PlayerHandler);
			this.addChild(m_GameHUD);
		}
		
		public override function InitializeEventListeners():void
		{
			State_PlayerSelection.eventDispatcher.addEventListener(PlayerInformationEvent.SEND_PLAYER_INFORMATION_EVENT, eh_GetPlayerInformation);
			
			m_PlayerHandler.InitializeEventListeners();
			m_GameHUD.InitializeEventListeners();
		}
		
		public override function Update():void
		{
			m_PlayerHandler.Update();
			
			m_GameHUD.Update();
		}
		
		public override function Begin():void
		{
			m_PlayerHandler.Begin();
			
			m_GameHUD.Begin();
		}
		
		public override function Leave():void
		{
			m_PlayerHandler.Leave();
			
			m_GameHUD.Leave();
		}
		
		private function eh_GetPlayerInformation(evt:PlayerInformationEvent):void
		{
			m_PlayerHandler.SetPlayerInformation(evt.E_PlayerInformation);
			
			m_GameHUD.SetPlayerInformation(evt.E_PlayerInformation);
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return g_eventDispatcher;
		}
	}
}