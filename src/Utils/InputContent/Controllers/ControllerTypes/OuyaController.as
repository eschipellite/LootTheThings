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
	public class OuyaController extends GameController
	{
		public function OuyaController(index:int) 
		{
			super(index);
			
			if (m_IsOnConsole)
			{
				m_ControllerButtons[RIGHT_BUMPER].Index = 5;
				m_ControllerButtons[LEFT_BUMPER].Index = 20;
				m_ControllerButtons[RIGHT_TRIGGER].Index = 19;
				m_ControllerButtons[LEFT_TRIGGER].Index = 18;
				m_ControllerButtons[BUTTON_A].Index = 14;
				m_ControllerButtons[BUTTON_B].Index = 16;
				m_ControllerButtons[BUTTON_C].Index = 17;
				m_ControllerButtons[BUTTON_D].Index = 15;
			}
		}
		
		override public function get DPad():Point
		{
			if (!m_IsOnConsole)
			{
				return super.DPad;
			}
			else
			{
				if (m_GameInputDevice != null)
				{
					var direction:Point = new Point(0, 0);
					
					if (m_GameInputDevice.getControlAt(11).value == 1)
					{
						direction.y += 1;
					}
					
					if (m_GameInputDevice.getControlAt(10).value == 1)
					{
						direction.y -= 1;
					}
					
					if (m_GameInputDevice.getControlAt(12).value == 1)
					{
						direction.x -= 1;
					}
					
					if (m_GameInputDevice.getControlAt(13).value == 1)
					{
						direction.x += 1;
					}
					
					return direction;
				}
				
				return new Point(0, 0);
			}
		}
	}
}