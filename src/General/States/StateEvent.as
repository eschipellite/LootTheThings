package General.States 
{
	import General.States.StateEvent;
	import flash.events.Event;
	
	public class StateEvent extends Event
	{
		public static const MOVE_TO_STATE_EVENT:String = "MOVE_TO_STATE_EVENT";
		
		public var E_State:int;
		
		public function StateEvent(type:String, state:int = -1) 
		{
			super(type, false, false);
			
			E_State = state;
		}	
	}
}