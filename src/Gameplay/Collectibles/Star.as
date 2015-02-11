package Gameplay.Collectibles 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class Star extends Sprite
	{
		private var m_Image:Image;
		
		private var m_ShouldRespawn:Boolean;
		
		public function Star() 
		{
			m_ShouldRespawn = false;
		}
		
		public function Initialize(shouldRespawn:Boolean = false):void
		{
			m_Image = ImageLoader.GetImage(EmbeddedImages_Collectibles.Gameplay_Star);
			m_ShouldRespawn = shouldRespawn;
			
			this.addChild(m_Image);
		}
		
		public function SetPosition(position:Point):void
		{
			m_Image.x = position.x;
			m_Image.y = position.y;
		}
		
		public function get Size():Point
		{
			return new Point(m_Image.FrameWidth, m_Image.FrameHeight);
		}
		
		public function get CollisionBounds():Rectangle
		{
			return m_Image.CollisionBounds;
		}
		
		public function get ShouldRespawn():Boolean
		{
			return m_ShouldRespawn;
		}
	}

}