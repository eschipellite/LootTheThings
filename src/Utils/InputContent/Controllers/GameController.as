package Utils.InputContent.Controllers 
{
	import flash.geom.Point;
	import flash.ui.GameInputDevice;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class GameController 
	{
		protected var m_GameInputDevice:GameInputDevice;
		
		protected var m_Index:int;
		
		protected var m_DeadZone:Number = .1;
		
		public function GameController(index:int) 
		{
			m_GameInputDevice = null;
			m_Index = index;
		}
		
		public function set Device(device:GameInputDevice):void
		{
			m_GameInputDevice = device;
		}
		
		public function get Device():GameInputDevice
		{
			return m_GameInputDevice;
		}
		
		public function get Index():int
		{
			return m_Index;
		}
		
		public function get LeftStick():Point
		{
			if (m_GameInputDevice != null)
			{
				var leftStickX:Number = checkDeadZone(m_GameInputDevice.getControlAt(0).value);
				var leftStickY:Number = checkDeadZone(m_GameInputDevice.getControlAt(1).value);
				
				return new Point(leftStickX, leftStickY);
			}
			
			return new Point(0, 0);
		}
		
		protected function checkDeadZone(value:Number):Number
		{
			if (value <= m_DeadZone && value >= -m_DeadZone)
			{
				return 0;
			}
			
			return value;
		}
	}
}