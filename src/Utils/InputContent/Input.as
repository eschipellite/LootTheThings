package Utils.InputContent 
{
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import Utils.Collision.CircleBounds;
	import Utils.GameTime;
	
	public class Input 
	{	
		private static var m_KeyButtons:Dictionary = new Dictionary();
		
		private static var m_MouseState:int = Mouse.UP;
		private static var m_MousePosition:Point = new Point();
		private static var m_MouseWheel:int = 0;
		
		//Tap Variables
		private static var m_TapDown:Boolean = false;
		private static var m_ScrollSlide:Boolean = false;
		private static var m_SwipeSlide:Boolean = false;
		private static var m_Tap:Boolean = false;
		
		private static var m_StartTapPosition:Point = new Point();
		private static var m_PreviousTapPosition:Point = new Point();
		
		private static var m_ScrollSpeeds:Vector.<Number> = new Vector.<Number>();
		private static var m_SwipeSpeeds:Vector.<Number> = new Vector.<Number>();
		
		private static var m_ScrollAmount:Number = 0;
		private static var m_SwipeAmount:Number = 0;
		private static var m_SlideReduction:Number = .25;
		private static var m_SwipeReduction:Number = .25;
		
		private static var m_DistanceForTap:int = 24;
		private static var m_ScrollSpeedsCapacity:int = 10;
		private static var m_SwipeSpeedsCapacity:int = 10;
		
		public static function KeyDownListener(e:KeyboardEvent):void
		{
			checkKeyExist(e.keyCode);
			
			m_KeyButtons[e.keyCode].Down = true;
			m_KeyButtons[e.keyCode].Pressed = m_KeyButtons[e.keyCode].Down && m_KeyButtons[e.keyCode].Up;
			m_KeyButtons[e.keyCode].Up = false;
		}
		
		public static function KeyUpListener(e:KeyboardEvent):void
		{
			checkKeyExist(e.keyCode);
			
			m_KeyButtons[e.keyCode].Down = false;
			m_KeyButtons[e.keyCode].Pressed = false;
			m_KeyButtons[e.keyCode].Up = true;
		}
		
		public static function SetMouse(mouseState:int):void
		{
			if (m_MouseState == Mouse.UP && mouseState == Mouse.DOWN)
			{
				m_MouseState = Mouse.CLICKED;
			}
			else
			{
				m_MouseState = mouseState;
			}
		}
		
		public static function SetMousePosition(mousePosition:Point):void
		{
			m_MousePosition = mousePosition;
		}
		
		private static function checkKeyExist(keyCode:int):void
		{
			if (m_KeyButtons[keyCode] == null)
			{
				m_KeyButtons[keyCode] = new KeyButton(keyCode);
			}
		}
		
		private static function checkScrollAndSwipe():void
		{
			if (!m_TapDown)
			{
				if (MouseDown)
				{
					m_TapDown = true;
					m_ScrollSlide = false;
					m_SwipeSlide = false;
					m_ScrollSpeeds = new Vector.<Number>();
					m_SwipeSpeeds = new Vector.<Number>();
					m_Tap = false;
					
					m_StartTapPosition = MousePosition;
					m_PreviousTapPosition = MousePosition;
				}
			}
			else
			{	
				m_ScrollAmount = MousePosition.y - m_PreviousTapPosition.y;
				m_SwipeAmount = MousePosition.x - m_PreviousTapPosition.x;
				
				addScrollToList(m_ScrollAmount);
				addSwipeToList(m_SwipeAmount);
				
				m_PreviousTapPosition = MousePosition;
				
				if (MouseUp)
				{
					m_TapDown = false;
					
					if (Math.abs(Point.distance(MousePosition, m_StartTapPosition)) <= m_DistanceForTap)
					{
						m_Tap = true;
					}
					else
					{
						m_ScrollSlide = true;
						m_SwipeSlide = true;
					}
				}
			}
		}
		
		private static function checkScrollSlide():void
		{
			if (m_ScrollSlide)
			{
				var scrollAverage:Number = 0;
				
				for each(var scrollAmount:Number in m_ScrollSpeeds)
				{
					scrollAverage += scrollAmount;
				}
				
				scrollAverage = scrollAverage / m_ScrollSpeeds.length;
				
				addScrollToList(scrollAverage * m_SlideReduction);
				
				m_ScrollAmount = scrollAverage;
			}
		}
		
		private static function checkSwipeSlide():void
		{
			if (m_SwipeSlide)
			{
				var swipeAverage:Number = 0;
				
				for each(var swipeAmount:Number in m_SwipeSpeeds)
				{
					swipeAverage += swipeAmount;
				}
				
				swipeAverage = swipeAverage / m_SwipeSpeeds.length;
				
				addSwipeToList(swipeAverage * m_SwipeReduction);
				
				m_SwipeAmount = swipeAverage;
			}
		}
		
		private static function addScrollToList(scrollAmount:Number):void
		{
			m_ScrollSpeeds.push(scrollAmount);
			
			if (m_ScrollSpeeds.length > m_ScrollSpeedsCapacity)
			{
				m_ScrollSpeeds.splice(0, 1);
			}
		}
		
		private static function addSwipeToList(swipeAmount:Number):void
		{
			m_SwipeSpeeds.push(swipeAmount);
			
			if (m_SwipeSpeeds.length > m_SwipeSpeedsCapacity)
			{
				m_SwipeSpeeds.splice(0, 1);
			}
		}
		
		public static function Down(keyCode:int):Boolean
		{
			checkKeyExist(keyCode);
			
			return m_KeyButtons[keyCode].Down;
		}
		
		public static function Pressed(keyCode:int):Boolean
		{
			checkKeyExist(keyCode);
			
			return m_KeyButtons[keyCode].Pressed;
		}
		
		public static function Up(keyCode:int):Boolean
		{
			checkKeyExist(keyCode);
			
			return m_KeyButtons[keyCode].Up;
		}
		
		public static function UpdateMouseWheel(delta:int):void
		{
			m_MouseWheel = delta * -1;
		}
		
		public static function Update():void
		{
			for each(var keyButton:KeyButton in m_KeyButtons)
			{
				keyButton.Pressed = false;
			}
			
			if (m_MouseState == Mouse.CLICKED)
			{
				m_MouseState = Mouse.DOWN;
			}
			
			m_MouseWheel = 0;
			
			m_Tap = false;
			
			m_ScrollAmount = 0;
			m_SwipeAmount = 0;
			
			checkScrollAndSwipe();
			
			checkScrollSlide();
			checkSwipeSlide();
		}
		
		public static function get MousePosition():Point
		{
			return new Point(m_MousePosition.x, m_MousePosition.y);
		}
		
		public static function get MouseClick():Boolean
		{
			return m_MouseState == Mouse.CLICKED;
		}
		
		public static function get MouseDown():Boolean
		{
			return m_MouseState == Mouse.DOWN;
		}
		
		public static function get MouseUp():Boolean
		{
			return m_MouseState == Mouse.UP;
		}
		
		public static function get ScrollAmount():int
		{
			return m_MouseWheel;
		}
		
		public static function GetTapBounds(radius:int = 1):CircleBounds
		{
			return new CircleBounds(m_MousePosition, radius);
		}
		
		public static function get Tap():Boolean
		{
			return m_Tap;
		}
		
		public static function get TapScrollAmount():Number
		{
			return m_ScrollAmount;
		}
		
		public static function get TapSwipeAmount():Number
		{
			return m_SwipeAmount;
		}
		
		public static function get TapDown():Boolean
		{
			return m_TapDown;
		}
		
		public static function ResetSwipeList():void
		{
			m_SwipeSpeeds = new Vector.<Number>();
			
			m_SwipeAmount = 0;
		}
		
		public static function ResetScrollList():void
		{
			m_ScrollSpeeds = new Vector.<Number>();
			
			m_ScrollAmount = 0;
		}
	}
}