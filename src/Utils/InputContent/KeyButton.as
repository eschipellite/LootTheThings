package Utils.InputContent 
{
	public class KeyButton 
	{
		private var m_Down:Boolean;
		private var m_Pressed:Boolean;
		private var m_Up:Boolean;
		
		private var m_KeyCode:int;
		
		public function KeyButton(keyCode:int) 
		{
			m_Down = false;
			m_Pressed = false;
			m_Up = true;
			
			m_KeyCode = keyCode;
		}
		
		public function get Down():Boolean
		{
			return m_Down;
		}
		
		public function set Down(down:Boolean):void
		{
			m_Down = down;
		}
		
		public function get Pressed():Boolean
		{
			return m_Pressed;
		}
		
		public function set Pressed(pressed:Boolean):void
		{
			m_Pressed = pressed;
		}
		
		public function get Up():Boolean
		{
			return m_Up;
		}
		
		public function set Up(up:Boolean):void
		{
			m_Up = up;
		}
		
		public function get KeyCode():int
		{
			return m_KeyCode;
		}
	}
}