package Menu.PlayerSelection.Events 
{
	import General.States.StateEvent;
	import flash.events.Event;
	import Menu.PlayerSelection.PlayerInformation;
	
	public class LevelSelectorEvent extends Event
	{
		public static const ADJUST_ROOM_NUMBER_EVENT:String = "ADJUST_ROOM_NUMBER_EVENT";
		public static const ADJUST_DIVERGENCE_EVENT:String = "ADJUST_DIVERGENCE_EVENT";
		public static const SET_LEVEL_INFORMATION_EVENT:String = "SET_LEVEL_INFORMATION_EVENT";
		public static const LEAVE_LEVEL_SELECTION_EVENT:String = "LEAVE_LEVEL_SELECTION_EVENT";
		
		public var E_Adjustment:int;
		
		public var E_NumRooms:int;
		public var E_Divergence:int;
		
		public function LevelSelectorEvent(type:String, adjustment:int = 0, numRooms:int = 1, divergence:int = 1) 
		{
			super(type, false, false);
			
			E_Adjustment = adjustment;
			
			E_NumRooms = numRooms;
			E_Divergence = divergence;
		}	
	}
}