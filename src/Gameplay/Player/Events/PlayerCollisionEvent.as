package Gameplay.Player.Events 
{
	import flash.events.Event;
	import Gameplay.Player.Player;
	
	public class PlayerCollisionEvent extends Event
	{
		public static const CHECK_COLLECTIBLE_COLLISION_EVENT:String = "CHECK_COLLECTIBLE_COLLISION_EVENT";
		
		public var E_Player:Player;
		
		public function PlayerCollisionEvent(type:String, player:Player) 
		{
			super(type, false, false);
			
			E_Player = player;
		}	
	}
}