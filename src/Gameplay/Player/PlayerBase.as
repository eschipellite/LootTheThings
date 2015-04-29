package Gameplay.Player 
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerBase extends Sprite
	{
		private var m_Base:Rectangle;
		
		private var m_BaseImage:Image;
		
		public function PlayerBase() 
		{
			
		}
		
		public function Initialize(imageSource:Class, size:Point):void
		{
			m_Base = new Rectangle(0, 0, size.x, size.y);
			
			m_BaseImage = ImageLoader.GetImage(imageSource);
			m_BaseImage.x -= (m_BaseImage.FrameWidth - m_Base.width) * 0.5;
			m_BaseImage.y -= (m_BaseImage.FrameHeight - m_Base.height) * 0.5;
			
			this.addChild(m_BaseImage);
		}
		
		public function SetBaseFrame(frame:int):void
		{
			m_BaseImage.Frame = frame;
		}
		
		public function IncrementBaseFrame():void
		{
			m_BaseImage.Frame++;
		}
		
		public function DecrementBaseFrame():void
		{
			m_BaseImage.Frame--;
		}
		
		public function get BaseFrame():int
		{
			return m_BaseImage.Frame;
		}
		
		public function get FrameWidth():int
		{
			return m_Base.width;
		}
		
		public function get FrameHeight():int
		{
			return m_Base.height;
		}
		
		public function set Rotation(degrees:Number):void
		{
			UtilMethods.Rotation(this, degrees, this.Origin);
		}
		
		public function get Origin():Point
		{
			return new Point(m_Base.width * 0.5, m_Base.height * 0.5);
		}
	}
}