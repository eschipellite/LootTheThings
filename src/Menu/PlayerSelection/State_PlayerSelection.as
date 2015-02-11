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
		
		public function State_PlayerSelection() 
		{
			m_PlayerSelector = new PlayerSelector();
		}
		
		public override function Initialize():void
		{
			m_Background = ImageLoader.GetImage(EmbeddedImages_PlayerSelection.PlayerSelection_Background);
			
			m_PlayerSelector.Initialize();
			
			this.addChild(m_Background);
			this.addChild(m_PlayerSelector);
		}
		
		public override function InitializeEventListeners():void
		{
			m_PlayerSelector.InitializeEventListeners();
		}
		
		public override function Update():void
		{
			m_PlayerSelector.Update();
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
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return g_eventDispatcher;
		}
	}
}