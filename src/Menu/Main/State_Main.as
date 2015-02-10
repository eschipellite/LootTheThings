package Menu.Main 
{
	import General.States.GameState;
	import Menu.Main.Buttons.ExitButton;
	import Menu.Main.Buttons.MenuButton;
	import Menu.Main.Buttons.OptionsButton;
	import Menu.Main.Buttons.PlayButton;
	import Menu.MenuScroller;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class State_Main extends GameState
	{	
		private var m_Background:Image;
		
		private var m_MenuScroller:MenuScroller;
		
		public function State_Main() 
		{
			m_MenuScroller = new MenuScroller();
		}
		
		public override function Initialize():void
		{
			m_Background = ImageLoader.GetImage(EmbeddedImages_Main.Main_Background);
			
			var menuButtons:Vector.<MenuButton> = new Vector.<MenuButton>();
			menuButtons.push(new PlayButton());
			menuButtons.push(new OptionsButton());
			menuButtons.push(new ExitButton());
			
			m_MenuScroller.Initialize(menuButtons);
			
			this.addChild(m_Background);
			this.addChild(m_MenuScroller);
		}
		
		public override function InitializeEventListeners():void
		{
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
	}
}