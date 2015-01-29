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
	}
}