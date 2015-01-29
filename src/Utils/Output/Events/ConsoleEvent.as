package Utils.Output.Events 
{
	import flash.events.Event;
	
	public class ConsoleEvent extends Event
	{		
		public static const WRITE_TO_CONSOLE_EVENT:String = "WRITE_TO_CONSOLE_EVENT";
		
		public var E_Text:String;
		
		public var E_Duration:Number;
		
		public function ConsoleEvent(type:String, text:String, duration:Number = 5) 
		{
			super(type, false, false);
			
			E_Text = text;
			
			E_Duration = duration;
		}	
	}
}