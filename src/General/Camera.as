package General 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Camera 
	{
		private static var m_CameraRectangle:Rectangle = new Rectangle();
		
		private static var m_Source:Sprite = null;
		
		private static var m_WorldSize:Point = new Point(0, 0);
		
		private static var m_ScreenSize:Point = new Point(0, 0);
		private static var m_HalfScreenSize:Point = new Point(0, 0);
		
		private static var m_CameraMin:Point = new Point(0, 0);
		
		private static function setPrevious():void
		{
		}
		
		private static function checkBounds():void
		{
			if (m_CameraRectangle.x < m_CameraMin.x)
			{
				m_CameraRectangle.x = m_CameraMin.x;
			}
			
			if (m_CameraRectangle.x > m_WorldSize.x - m_ScreenSize.x)
			{
				m_CameraRectangle.x = m_WorldSize.x - m_ScreenSize.x;
			}
			
			if (m_CameraRectangle.y < m_CameraMin.y)
			{
				m_CameraRectangle.y = m_CameraMin.y;
			}
			
			if (m_CameraRectangle.y > m_WorldSize.y - m_ScreenSize.y)
			{
				m_CameraRectangle.y = m_WorldSize.y - m_ScreenSize.y;
			}
			
			m_Source.scrollRect = m_CameraRectangle;
		}
		
		public static function SetSource(sprite:Sprite, screenSize:Point):void
		{
			m_Source = sprite;
			
			m_ScreenSize = screenSize;
			
			m_HalfScreenSize = new Point(m_ScreenSize.x / 2, m_ScreenSize.y / 2);
			
			m_CameraRectangle = new Rectangle(0, 0, m_ScreenSize.x, m_ScreenSize.y)
		}
		
		public static function SetWorldSize(worldSize:Point):void
		{
			m_WorldSize = worldSize;
		}
		
		public static function SetCenteredPosition(position:Point):void
		{
			var centeredPosition:Point = new Point(position.x - m_HalfScreenSize.x, position.y - m_HalfScreenSize.y);
			
			SetPosition(centeredPosition);
		}
		
		public static function SetPosition(position:Point):void
		{
			m_CameraRectangle.x = position.x;
			m_CameraRectangle.y = position.y;
			
			m_Source.scrollRect = m_CameraRectangle;
			
			checkBounds();
		}
		
		public static function ConvertToCameraPoint(point:Point):Point
		{
			return new Point(point.x + m_CameraRectangle.x, point.y + m_CameraRectangle.y);
		}
		
		public static function AdjustPosition(adjustment:Point):void
		{
			m_CameraRectangle.x += adjustment.x;
			m_CameraRectangle.y += adjustment.y;
			
			m_Source.scrollRect = m_CameraRectangle;
			
			checkBounds();
		}
		
		public static function SetCameraMin(cameraMin:Point):void
		{
			m_CameraMin = cameraMin;
		}
		
		public static function get Position():Point
		{
			return new Point (m_CameraRectangle.x, m_CameraRectangle.y);
		}
		
		public static function get CenterPosition():Point
		{
			return new Point (m_CameraRectangle.x + m_HalfScreenSize.x, m_CameraRectangle.y + m_HalfScreenSize.y);
		}
	}
}