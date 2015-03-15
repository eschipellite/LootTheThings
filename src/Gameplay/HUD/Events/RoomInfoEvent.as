package Gameplay.HUD.Events 
{
	import flash.events.Event;
	import Gameplay.Level.RoomInfo;
	
	public class RoomInfoEvent extends Event
	{
		public static const SEND_ALL_ROOM_INFORMATION_EVENT:String = "SEND_ALL_ROOM_INFORMATION_EVENT";
		public static const SEND_ROOM_INFO_EVENT:String = "SEND_ROOM_INFO_EVENT";
		
		public var E_RoomInformation:Vector.<RoomInfo>;
		public var E_RoomInfo:RoomInfo;
		
		public function RoomInfoEvent(type:String, roomInformation:Vector.<RoomInfo> = null, roomInfo:RoomInfo = null) 
		{
			super(type, false, false);
			
			E_RoomInformation = roomInformation;
			E_RoomInfo = roomInfo;
		}	
	}
}