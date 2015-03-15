package Gameplay.Player.Events 
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class SpawnPlayersEvent extends Event
	{
		public static const SPAWN_PLAYERS_EVENT:String = "SPAWN_PLAYERS_EVENT";
		
		public var E_SpawnPoints:Vector.<Rectangle>;
		
		public var E_RoomPosition:Point;
		
		public function SpawnPlayersEvent(type:String, spawnPoints:Vector.<Rectangle>, roomPosition:Point) 
		{
			super(type, false, false);
			
			E_SpawnPoints = spawnPoints;
			
			E_RoomPosition = roomPosition;
		}	
	}
}