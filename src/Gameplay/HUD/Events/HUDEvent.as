package Gameplay.HUD.Events 
{
	import flash.events.Event;
	
	public class HUDEvent extends Event
	{
		public static const TOGGLE_HUD_EVENT:String = "TOGGLE_HUD_EVENT";
		public static const TOGGLE_RETURN_EVENT:String = "TOGGLE_RETURN_EVENT";
		
		public var E_PlayerIndex:int;
		
		public function HUDEvent(type:String, playerIndex:int) 
		{
			super(type, false, false);
			
			E_PlayerIndex = playerIndex;
		}	
	}
}