package Utils.InputContent.Controllers.ControllerTypes 
{
	import flash.geom.Point;
	import flash.ui.GameInputDevice;
	import Utils.InputContent.Controllers.GameController;
	import Utils.Output.Console;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class XboxController extends GameController
	{
		public function XboxController(index:int) 
		{
			super(index);
			
			m_ControllerButtons[RIGHT_BUMPER].Index = 11;
			m_ControllerButtons[LEFT_BUMPER].Index = 10;
			m_ControllerButtons[RIGHT_TRIGGER].Index = 9;
			m_ControllerButtons[LEFT_TRIGGER].Index = 8;
			m_ControllerButtons[BUTTON_A].Index = 4;
			m_ControllerButtons[BUTTON_B].Index = 6;
			m_ControllerButtons[BUTTON_C].Index = 7;
			m_ControllerButtons[BUTTON_D].Index = 5;
			m_ControllerButtons[LEFT_STICK_UP].Test = -1;
			m_ControllerButtons[LEFT_STICK_DOWN].Test = 1;
		}
		
		override public function get LeftStick():Point
		{
			var direction:Point = super.LeftStick;
			
			direction.y *= -1;
			
			return direction;
		}
		
		override public function get RightStick():Point
		{
			if (m_GameInputDevice != null)
			{
				var rightStickX:Number = checkDeadZone(m_GameInputDevice.getControlAt(2).value);
				var rightStickY:Number = checkDeadZone(m_GameInputDevice.getControlAt(3).value);
				
				return new Point(rightStickX, -rightStickY);
			}
			
			return new Point(0, 0);
		}
		
		override public function get DPad():Point
		{
			if (m_GameInputDevice != null)
			{
				var direction:Point = new Point(0, 0);
				
				if (m_GameInputDevice.getControlAt(17).value == 1)
				{
					direction.y += 1;
				}
				
				if (m_GameInputDevice.getControlAt(16).value == 1)
				{
					direction.y -= 1;
				}
				
				if (m_GameInputDevice.getControlAt(18).value == 1)
				{
					direction.x -= 1;
				}
				
				if (m_GameInputDevice.getControlAt(19).value == 1)
				{
					direction.x += 1;
				}
				
				return direction;
			}
			
			return new Point(0, 0);
		}
	}
}