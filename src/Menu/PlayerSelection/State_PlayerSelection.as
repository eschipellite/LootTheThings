package Menu.PlayerSelection 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import General.States.GameState;
	import Menu.Main.Buttons.MenuButton;
	import Menu.MenuScroller;
	import Menu.Buttons.BackToMainButton;
	import Menu.Setup.Buttons.NewGameButton;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class State_PlayerSelection extends GameState
	{	
		private static var g_eventDispatcher:IEventDispatcher = new EventDispatcher();
		
		private var m_Background:Image;
		
		private var m_PlayerSelector:PlayerSelector;
		private var m_LevelSelector:LevelSelector;
		
		public function State_PlayerSelection() 
		{
			m_PlayerSelector = new PlayerSelector();
			m_LevelSelector = new LevelSelector();
		}
		
		public override function Initialize():void
		{
			m_Background = ImageLoader.GetImage(EmbeddedImages_PlayerSelection.PlayerSelection_Background);
			
			m_PlayerSelector.Initialize();
			m_LevelSelector.Initialize();
			
			this.addChild(m_Background);
			this.addChild(m_PlayerSelector);
			this.addChild(m_LevelSelector);
		}
		
		public override function InitializeEventListeners():void
		{
			m_PlayerSelector.InitializeEventListeners();
			m_LevelSelector.InitializeEventListeners();
		}
		
		public override function Update():void
		{
			m_PlayerSelector.Update();
			m_LevelSelector.Update();
		}
		
		public override function Begin():void
		{
			reset();
		}
		
		public override function Leave():void
		{
			reset();
		}
		
		private function reset():void
		{
			m_PlayerSelector.Reset();
			m_LevelSelector.Reset();
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return g_eventDispatcher;
		}
	}
}