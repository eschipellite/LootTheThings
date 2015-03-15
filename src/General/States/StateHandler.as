package General.States 
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import Gameplay.State_Gameplay;
	import Menu.Main.State_Main;
	import Menu.Options.State_Options;
	import Menu.PlayerSelection.State_PlayerSelection;
	import Menu.Results.State_Results;
	import Menu.Setup.State_Setup;
	
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class StateHandler extends Sprite
	{
		private var m_State_Main:State_Main;
		private var m_State_Gameplay:State_Gameplay;
		private var m_State_Options:State_Options;
		private var m_State_Setup:State_Setup;
		private var m_State_PlayerSelection:State_PlayerSelection;
		private var m_State_Results:State_Results;
		
		private var m_State_Active:GameState;
		
		private static var g_eventDispatcher:IEventDispatcher = new EventDispatcher();
		
		public function StateHandler()
		{
			m_State_Main = new State_Main();
			m_State_Gameplay = new State_Gameplay();
			m_State_Options = new State_Options();
			m_State_Setup = new State_Setup();
			m_State_PlayerSelection = new State_PlayerSelection();
			m_State_Results = new State_Results();
			
			m_State_Active = new GameState();
		}
		
		public function Initialize():void
		{
			m_State_Main.Initialize();
			m_State_Gameplay.Initialize();
			m_State_Options.Initialize();
			m_State_Setup.Initialize();
			m_State_PlayerSelection.Initialize();
			m_State_Results.Initialize();
		}
		
		public function InitializeEventListeners():void
		{
			eventDispatcher.addEventListener(StateEvent.MOVE_TO_STATE_EVENT, eh_CheckMoveToState);
			
			m_State_Main.InitializeEventListeners();
			m_State_Gameplay.InitializeEventListeners();
			m_State_Options.InitializeEventListeners();
			m_State_Setup.InitializeEventListeners();
			m_State_PlayerSelection.InitializeEventListeners();
			m_State_Results.InitializeEventListeners();
		}
		
		public function StartGame():void
		{
			m_State_Active = m_State_Main;
			
			m_State_Active.Begin();
			
			this.addChild(m_State_Active);
		}
		
		public function Update():void
		{
			m_State_Active.Update();
		}
		
		private function eh_CheckMoveToState(evt:StateEvent):void
		{
			if (evt.E_State >= 0)
			{
				m_State_Active.Leave();
				
				if (this.contains(m_State_Active))
				{
					this.removeChild(m_State_Active);
				}
				
				switch (evt.E_State)
				{
					case StateValues.STATE_MAIN:
						m_State_Active = m_State_Main;
						break;
					case StateValues.STATE_GAMEPLAY:
						m_State_Active = m_State_Gameplay;
						break;
					case StateValues.STATE_OPTIONS:
						m_State_Active = m_State_Options;
						break;
					case StateValues.STATE_SETUP:
						m_State_Active = m_State_Setup;
						break;
					case StateValues.STATE_PLAYERSELECTION:
						m_State_Active = m_State_PlayerSelection;
						break;
					case StateValues.STATE_RESULTS:
						m_State_Active = m_State_Results;
						break;
				}
				
				m_State_Active.Begin();
				
				if (!this.contains(m_State_Active))
				{
					this.addChild(m_State_Active);
				}
			}
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return g_eventDispatcher;
		}
	}
}