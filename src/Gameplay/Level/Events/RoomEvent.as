package Gameplay.Level.Events 
{
	import flash.events.Event;
	
	public class RoomEvent extends Event
	{
		public static const CHANGE_ROOM_EVENT:String = "CHANGE_ROOM_EVENT";
		
		public var E_Exit:int;
		
		public function RoomEvent(type:String, exit:int) 
		{
			super(type, false, false);
			
			E_Exit = exit;
		}	
	}
}