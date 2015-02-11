package Menu.Results 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import Gameplay.HUD.Events.EndGameEvent;
	import Gameplay.State_Gameplay;
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
	public class State_Results extends GameState
	{	
		private static var g_eventDispatcher:IEventDispatcher = new EventDispatcher();
		
		private var m_Background:Image;
		
		private var m_MenuScroller:MenuScroller;
		
		private var m_WinnerTextField:TextField;
		
		public function State_Results() 
		{
			m_MenuScroller = new MenuScroller();
			
			m_WinnerTextField = new TextField();
		}
		
		public override function Initialize():void
		{
			m_Background = ImageLoader.GetImage(EmbeddedImages_Results.Results_Background);
			
			var menuButtons:Vector.<MenuButton> = new Vector.<MenuButton>();
			menuButtons.push(new BackToMainButton());
			m_MenuScroller.Initialize(menuButtons);
			
			createWinnerTextField();
			
			this.addChild(m_Background);
			this.addChild(m_MenuScroller);
			this.addChild(m_WinnerTextField);
		}
		
		public override function InitializeEventListeners():void
		{
			eventDispatcher.addEventListener(EndGameEvent.SET_WINNER_EVENT, eh_SetWinner);
		}
		
		public override function Update():void
		{
			m_MenuScroller.Update();
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
			m_MenuScroller.Reset();
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return g_eventDispatcher;
		}
		
		private function eh_SetWinner(evt:EndGameEvent):void
		{
			m_WinnerTextField.text = "Player " + evt.E_PlayerNum + " Won!";
		}
		
		private function createWinnerTextField():void
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 36;
			textFormat.align = TextFormatAlign.CENTER;
			
			m_WinnerTextField.defaultTextFormat = textFormat;
			m_WinnerTextField.width = Main.ScreenArea.x;
			
			m_WinnerTextField.wordWrap = true;
			m_WinnerTextField.selectable = false;
			
			m_WinnerTextField.y = 512;
		}
	}
}