package Utils.InputContent.Controllers 
{
	import flash.ui.GameInputDevice;
	import Utils.Output.Console;
	import Utils.Output.Events.ConsoleEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class Input_GameController 
	{
		private static var ms_GameControllers:Vector.<GameController> = new Vector.<GameController>();
		
		public function Input_GameController() 
		{
			
		}
		
		public static function AddController(gameInputDevice:GameInputDevice):void
		{
			ms_GameControllers.push(new GameController(gameInputDevice));
			
			Console.eventDispatcher.dispatchEvent(new ConsoleEvent(ConsoleEvent.WRITE_TO_CONSOLE_EVENT, "Controller Added"));
		}
		
		public static function RemoveController(gameInputDevice:GameInputDevice):void
		{
			var indexToRemove:int = -1;
			
			for (var index:int = 0; index < ms_GameControllers.length; index++)
			{
				if (ms_GameControllers[index].Device == gameInputDevice)
				{
					indexToRemove = index;
					break;
				}
			}
			
			if (indexToRemove >= 0)
			{
				ms_GameControllers.splice(indexToRemove, 1);
				
				Console.eventDispatcher.dispatchEvent(new ConsoleEvent(ConsoleEvent.WRITE_TO_CONSOLE_EVENT, "Controller Removed"));
			}
		}
		
		public static function Update():void
		{
			
		}
	}
}