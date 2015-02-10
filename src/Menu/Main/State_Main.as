package Menu.Main 
{
	import General.States.GameState;
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
			
			m_MenuScroller.Initialize();
			
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