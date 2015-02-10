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
	public class PlayStationController extends GameController
	{
		public function PlayStationController(index:int) 
		{
			super(index);
			
			m_ControllerButtons[RIGHT_BUMPER].Index = 13;
			m_ControllerButtons[LEFT_BUMPER].Index = 12;
			m_ControllerButtons[RIGHT_TRIGGER].Index = 23;
			m_ControllerButtons[LEFT_TRIGGER].Index = 22;
			m_ControllerButtons[BUTTON_A].Index = 18;
			m_ControllerButtons[BUTTON_B].Index = 20;
			m_ControllerButtons[BUTTON_C].Index = 21;
			m_ControllerButtons[BUTTON_D].Index = 19;
		}
		
		override public function get RightStick():Point
		{
			if (m_GameInputDevice != null)
			{
				var rightStickX:Number = checkDeadZone(m_GameInputDevice.getControlAt(2).value);
				var rightStickY:Number = checkDeadZone(m_GameInputDevice.getControlAt(3).value);
				
				return new Point(rightStickX, rightStickY);
			}
			
			return new Point(0, 0);
		}
		
		override public function get DPad():Point
		{
			if (m_GameInputDevice != null)
			{
				var direction:Point = new Point(0, 0);
				
				if (m_GameInputDevice.getControlAt(15).value == 1)
				{
					direction.y += 1;
				}
				
				if (m_GameInputDevice.getControlAt(14).value == 1)
				{
					direction.y -= 1;
				}
				
				if (m_GameInputDevice.getControlAt(16).value == 1)
				{
					direction.x -= 1;
				}
				
				if (m_GameInputDevice.getControlAt(17).value == 1)
				{
					direction.x += 1;
				}
				
				return direction;
			}
			
			return new Point(0, 0);
		}
	}
}