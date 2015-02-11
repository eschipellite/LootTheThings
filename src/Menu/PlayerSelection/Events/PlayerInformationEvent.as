package Menu.PlayerSelection.Events 
{
	import General.States.StateEvent;
	import flash.events.Event;
	import Menu.PlayerSelection.PlayerInformation;
	
	public class PlayerInformationEvent extends Event
	{
		public static const SEND_PLAYER_INFORMATION_EVENT:String = "SEND_PLAYER_INFORMATION_EVENT";
		
		public var E_PlayerInformation:Vector.<PlayerInformation>;
		
		public function PlayerInformationEvent(type:String, playerInformation:Vector.<PlayerInformation>) 
		{
			super(type, false, false);
			
			E_PlayerInformation = playerInformation;
		}	
	}
}