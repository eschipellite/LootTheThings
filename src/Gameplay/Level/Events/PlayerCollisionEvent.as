package Gameplay.Level.Events 
{
	import flash.events.Event;
	import Gameplay.Player.Player;
	
	public class PlayerCollisionEvent extends Event
	{
		public static const CHECK_PLAYER_X_COLLISION_EVENT:String = "CHECK_PLAYER_X_COLLISION_EVENT";
		public static const CHECK_PLAYER_Y_COLLISION_EVENT:String = "CHECK_PLAYER_Y_COLLISION_EVENT";
		public static const CHECK_PLAYER_AT_EXIT_EVENT:String = "CHECK_PLAYER_AT_EXIT_EVENT";
		public static const CHECK_PLAYER_COLLISION_WITH_ENEMIES_EVENT:String = "CHECK_PLAYER_COLLISION_WITH_ENEMIES_EVENT";
		
		public var E_Player:Player;
		
		public function PlayerCollisionEvent(type:String, player:Player) 
		{
			super(type, false, false);
			
			E_Player = player;
		}	
	}
}