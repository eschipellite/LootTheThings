package Menu.Main.Buttons 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import General.Embedded_Content.EmbeddedImages_General;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class MenuButton extends Sprite
	{
		protected var m_Image:Image;
		
		protected var m_Selected:Boolean;
		
		protected var m_ImageClass:Class;
		
		public function MenuButton() 
		{
			m_Selected = false;
			
			m_ImageClass = EmbeddedImages_General.General_NullButton;
		}
		
		public function Initialize():void
		{
			loadImage();
			
			this.addChild(m_Image);
		}
		
		protected function loadImage():void
		{
			m_Image = ImageLoader.GetImage(m_ImageClass);
		}
		
		public function Update():void
		{
			checkFrame();
		}
		
		public function Reset():void
		{
			m_Selected = false;
			m_Image.Frame = 0;
		}
		
		public function SetSelected(selected:Boolean):void
		{
			m_Selected = selected;
		}
		
		protected function checkFrame():void
		{
			if (m_Selected)
			{
				m_Image.Frame = 1;
			}
			else
			{
				m_Image.Frame = 0;
			}
		}
		
		public function SetPosition(position:Point):void
		{
			m_Image.x = position.x;
			m_Image.y = position.y;
		}
		
		public function DoAction():void
		{
			
		}
	}

}