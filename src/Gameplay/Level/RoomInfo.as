package Gameplay.Level 
{
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class RoomInfo 
	{
		private var m_X:int;
		private var m_Y:int;
		private var m_RoomState:int;
		
		public function RoomInfo(x:int, y:int, roomState:int) 
		{
			m_X = x;
			m_Y = y;
			m_RoomState = roomState;
		}
		
		public function get X():int
		{
			return m_X;
		}
		
		public function get Y():int
		{
			return m_Y;
		}
		
		public function get RoomState():int
		{
			return m_RoomState;
		}
	}
}