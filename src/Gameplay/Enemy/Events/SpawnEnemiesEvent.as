package Gameplay.Enemy.Events 
{
	import flash.events.Event;
	import Gameplay.Level.Room;
	import Gameplay.Player.Player;
	
	public class SpawnEnemiesEvent extends Event
	{
		public static const SPAWN_ENEMIES_EVENT:String = "SPAWN_ENEMIES_EVENT";
		
		public function SpawnEnemiesEvent(type:String) 
		{
			super(type, false, false);
		}	
	}
}