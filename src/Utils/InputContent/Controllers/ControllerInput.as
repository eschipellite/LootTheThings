package Utils.InputContent.Controllers 
{
	import flash.ui.GameInputDevice;
	import Utils.InputContent.Controllers.ControllerTypes.ControllerTypes;
	import Utils.InputContent.Controllers.ControllerTypes.OuyaController;
	import Utils.InputContent.Controllers.ControllerTypes.PlayStationController;
	import Utils.InputContent.Controllers.ControllerTypes.XboxController;
	import Utils.Output.Console;
	/**
	 * ...
	 * @author ...
	 */
	public class ControllerInput 
	{
		private static var ms_GameControllers:Vector.<GameController> = new Vector.<GameController>();
		
		private static const MAX_CONTROLLERS:int = 4;
		
		public function ControllerInput() 
		{
		}
		
		public static function Initialize():void
		{
			for (var index:int = 0; index < MAX_CONTROLLERS; index++)
			{
				ms_GameControllers.push(new GameController(index));
			}
		}
		
		public static function AddController(gameInputDevice:GameInputDevice):void
		{
			var controllerIndex:int = -1;
			
			for (var index:int = 0; index < ms_GameControllers.length; index++)
			{				
				if (ms_GameControllers[index].Device == null)
				{
					ms_GameControllers[index] = setControllerType(gameInputDevice.name, ms_GameControllers[index].Index);
					ms_GameControllers[index].Device = gameInputDevice;
					controllerIndex = ms_GameControllers[index].Index + 1;
					ms_GameControllers[index].Device.enabled = true;
					
					break;
				}
			}
			
			Console.AddOutput("Controller " + controllerIndex.toString() + " added", 10);
		}
		
		public static function RemoveController(gameInputDevice:GameInputDevice):void
		{
			var controllerIndex:int = -1;
			
			for (var index:int = 0; index < ms_GameControllers.length; index++)
			{
				if (ms_GameControllers[index].Device == gameInputDevice)
				{
					ms_GameControllers[index].Device = null;
					controllerIndex = ms_GameControllers[index].Index + 1;
				}
			}
			
			Console.AddOutput("Controller " + controllerIndex.toString() + " removed", 10);
		}
		
		public static function Update():void
		{
			for each(var controller:GameController in ms_GameControllers)
			{
				controller.Update();
			}
		}
		
		public static function GetController(controllerIndex:int):GameController
		{
			return ms_GameControllers[controllerIndex];
		}
		
		public static function GetAllControllers():Vector.<GameController>
		{
			return ms_GameControllers;
		}
		
		private static function setControllerType(controllerName:String, controllerIndex:int):GameController
		{
			switch(controllerName)
			{
				case ControllerTypes.XBOX_STANDARD:
					return new XboxController(controllerIndex);
				case ControllerTypes.PLAYSTATION_STANDARD:
					return new PlayStationController(controllerIndex);
					break;
				default:
					return new OuyaController(controllerIndex);
					break;
			}
		}
	}
}