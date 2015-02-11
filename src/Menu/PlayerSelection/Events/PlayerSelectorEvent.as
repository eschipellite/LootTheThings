package Menu.PlayerSelection.Events 
{
	import General.States.StateEvent;
	import flash.events.Event;
	import Menu.PlayerSelection.PlayerInformation;
	
	public class PlayerSelectorEvent extends Event
	{
		public static const LEAVE_PLAYER_SELECTION_EVENT:String = "LEAVE_PLAYER_SELECTION_EVENT";
		
		public function PlayerSelectorEvent(type:String) 
		{
			super(type, false, false);
		}	
	}
}