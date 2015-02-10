package Utils.InputContent.Controllers 
{
	/**
	 * ...
	 * @author ...
	 */
	public class ControllerButton 
	{
		public var Up:Boolean;
		public var Down:Boolean;
		public var Pressed:Boolean;
		public var Index:int;
		public var Test:int;
		
		public function ControllerButton(index:int, test:int = 1) 
		{
			Up = true;
			Down = false;
			Pressed = false;
			Index = index;
			Test = test;
		}
		
	}

}