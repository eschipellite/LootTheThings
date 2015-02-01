package Utils.InputContent.Controllers.ControllerTypes 
{
	import flash.geom.Point;
	import flash.ui.GameInputDevice;
	import Utils.InputContent.Controllers.GameController;
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
		}
		
		override public function get LeftStick():Point
		{
			if (m_GameInputDevice != null)
			{
				var leftStickX:Number = checkDeadZone(m_GameInputDevice.getControlAt(0).value);
				var leftStickY:Number = checkDeadZone(m_GameInputDevice.getControlAt(1).value);
				
				return new Point(leftStickX, -leftStickY);
			}
			
			return new Point(0, 0);
		}
	}
}