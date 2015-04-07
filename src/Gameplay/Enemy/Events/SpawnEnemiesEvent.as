package Gameplay.Enemy.Events 
{
	import flash.events.Event;
	import Gameplay.Level.Room;
	import Gameplay.Level.Waves.Wave;
	import Gameplay.Level.Waves.WaveInfo;
	import Gameplay.Player.Player;
	
	public class SpawnEnemiesEvent extends Event
	{
		public static const SPAWN_ENEMIES_EVENT:String = "SPAWN_ENEMIES_EVENT";
		
		public var E_WaveInfo:WaveInfo;
		
		public function SpawnEnemiesEvent(type:String, waveInfo:WaveInfo) 
		{
			super(type, false, false);
			
			E_WaveInfo = waveInfo;
		}	
	}
}