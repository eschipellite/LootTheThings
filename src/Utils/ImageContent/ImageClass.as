package Utils.ImageContent 
{
	import flash.geom.Point;
	public class ImageClass
	{
		private var m_ImageClass:Class;
		
		private var m_FramesX:int;
		private var m_FramesY:int;
		
		public function ImageClass(imageClass:Class, framesX:int = 1, framesY:int = 1)
		{
			m_ImageClass = imageClass;
			m_FramesX = framesX;
			m_FramesY = framesY;
		}
		
		public function get Source():Object
		{
			return new m_ImageClass();
		}
		
		public function get FramesX():int
		{
			return m_FramesX;
		}
		
		public function get FramesY():int
		{
			return m_FramesY;
		}
	}
}