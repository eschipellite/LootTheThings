package Utils.InputContent.Controllers 
{
	import flash.geom.Point;
	import flash.ui.GameInputDevice;
	import flash.utils.Dictionary;
	import Utils.Output.Console;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class GameController 
	{
		protected var m_GameInputDevice:GameInputDevice;
		
		protected var m_Index:int;
		
		protected var m_DeadZone:Number = .2;
		
		protected var m_ControllerButtons:Dictionary = new Dictionary();
		
		public static const RIGHT_BUMPER:String = "RIGHT_BUMPER";
		public static const LEFT_BUMPER:String = "LEFT_BUMPER";
		public static const RIGHT_TRIGGER:String = "RIGHT_TRIGGER";
		public static const LEFT_TRIGGER:String = "LEFT_TRIGGER";
		public static const BUTTON_A:String = "BUTTON_A";
		public static const BUTTON_B:String = "BUTTON_B";
		public static const BUTTON_C:String = "BUTTON_C";
		public static const BUTTON_D:String = "BUTTON_D";
		public static const LEFT_STICK_UP:String = "LEFT_STICK_UP";
		public static const LEFT_STICK_DOWN:String = "LEFT_STICK_DOWN";
		public static const LEFT_STICK_LEFT:String = "LEFT_STICK_LEFT";
		public static const LEFT_STICK_RIGHT:String = "LEFT_STICK_RIGHT";
		
		protected var m_IsOnConsole:Boolean;
		
		public function GameController(index:int) 
		{
			m_GameInputDevice = null;
			m_Index = index;
			
			m_IsOnConsole = Main.IsOnConsole;
			
			m_ControllerButtons[RIGHT_BUMPER] = new ControllerButton(19);
			m_ControllerButtons[LEFT_BUMPER] = new ControllerButton(18);
			m_ControllerButtons[RIGHT_TRIGGER] = new ControllerButton(11);
			m_ControllerButtons[LEFT_TRIGGER] = new ControllerButton(10);
			m_ControllerButtons[BUTTON_A] = new ControllerButton(6);
			m_ControllerButtons[BUTTON_B] = new ControllerButton(7);
			m_ControllerButtons[BUTTON_C] = new ControllerButton(8);
			m_ControllerButtons[BUTTON_D] = new ControllerButton(9);
			m_ControllerButtons[LEFT_STICK_UP] = new ControllerButton(1);
			m_ControllerButtons[LEFT_STICK_DOWN] = new ControllerButton(1, -1);
			m_ControllerButtons[LEFT_STICK_LEFT] = new ControllerButton(0, -1);
			m_ControllerButtons[LEFT_STICK_RIGHT] = new ControllerButton(0);
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
		
		public function get Connected():Boolean
		{
			return m_GameInputDevice != null;
		}
		
		public function Update():void
		{
			checkButtons();
		}
		
		protected function checkButtons():void
		{
			if (m_GameInputDevice != null)
			{
				for each(var controllerButton:ControllerButton in m_ControllerButtons)
				{
					var state:Number = m_GameInputDevice.getControlAt(controllerButton.Index).value;
					
					if (state != controllerButton.Test)
					{
						controllerButton.Down = false;
						controllerButton.Pressed = false;
						controllerButton.Up = true;
					}
					else
					{
						controllerButton.Down = true;
						controllerButton.Pressed = controllerButton.Down && controllerButton.Up;
						controllerButton.Up = false;
					}
				}
			}
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
		
		public function get RightStick():Point
		{
			if (m_GameInputDevice != null)
			{
				var rightStickX:Number = checkDeadZone(m_GameInputDevice.getControlAt(3).value);
				var rightStickY:Number = checkDeadZone(m_GameInputDevice.getControlAt(4).value);
				
				return new Point(rightStickX, rightStickY);
			}
			
			return new Point(0, 0);
		}
		
		public function get DPad():Point
		{
			if (m_GameInputDevice != null)
			{
				var direction:Point = new Point(0, 0);
				
				if (m_GameInputDevice.getControlAt(14).value == 1)
				{
					direction.y += 1;
				}
				
				if (m_GameInputDevice.getControlAt(15).value == 1)
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
		
		public function ButtonPressed(buttonName:String):Boolean
		{
			if (m_ControllerButtons[buttonName])
			{
				return m_ControllerButtons[buttonName].Pressed;
			}
			
			return false;
		}
		
		public function ButtonDown(buttonName:String):Boolean
		{
			if (m_ControllerButtons[buttonName])
			{
				return m_ControllerButtons[buttonName].Down;
			}
			
			return false;
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