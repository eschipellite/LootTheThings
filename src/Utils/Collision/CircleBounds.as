package Utils.Collision {
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CircleBounds
	{		
		private var m_Position:Point;
		
		private var m_Radius:Number;
		
		public function CircleBounds(position:Point, radius:Number) 
		{
			m_Position = position;
			m_Radius = radius;
		}
		
		public function UpdatePosition(position:Point):void
		{
			m_Position = position;
		}
		
		public function CheckCollisionWithCircle(otherCircle:CircleBounds):Boolean
		{
			var thisCirclePosition:Point = this.CenterPosition;
			var otherCirclePosition:Point = otherCircle.CenterPosition;
			var distanceSquared:Number = (thisCirclePosition.x - otherCirclePosition.x) * (thisCirclePosition.x - otherCirclePosition.x) + (thisCirclePosition.y - otherCirclePosition.y) * (thisCirclePosition.y - otherCirclePosition.y);
				
			if (distanceSquared < (m_Radius + otherCircle.Radius) * (m_Radius + otherCircle.Radius))
			{
				return true;
			}
			
			return false;
		}
		
		//http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection (ClickerMonkey)
		public function CheckCollisionWithRectangle(rectBounds:Rectangle):Boolean
		{
			var closestX:Number = (m_Position.x < rectBounds.x ? rectBounds.x : (m_Position.x > rectBounds.x + rectBounds.width ? rectBounds.x + rectBounds.width : m_Position.x));
			var closestY:Number = (m_Position.y < rectBounds.y ? rectBounds.y : (m_Position.y > rectBounds.y + rectBounds.height ? rectBounds.y + rectBounds.height : m_Position.y));
			
			var dx:Number = closestX - m_Position.x;
			var dy:Number = closestY - m_Position.y;
			
			return ((dx * dx + dy * dy) <= m_Radius * m_Radius);
		}
		
		public function get Position():Point
		{
			return m_Position;
		}
		
		public function get CenterPosition():Point
		{
			return new Point(m_Position.x + m_Radius, m_Position.y + m_Radius);
		}
		
		public function get Radius():Number
		{
			return m_Radius;
		}
		
		public function get BoundingBox():Rectangle
		{
			return new Rectangle(m_Position.x, m_Position.y, m_Radius * 2, m_Radius * 2);
		}
	}
}