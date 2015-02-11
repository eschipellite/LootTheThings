package Gameplay.HUD.Events 
{
	import flash.events.Event;
	import Gameplay.Player.Player;
	
	public class EndGameEvent extends Event
	{
		public static const SET_WINNER_EVENT:String = "SET_WINNER_EVENT";
		
		public var E_PlayerNum:int;
		
		public function EndGameEvent(type:String, playerNum:int) 
		{
			super(type, false, false);
			
			E_PlayerNum = playerNum;
		}	
	}
}