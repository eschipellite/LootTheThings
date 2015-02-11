package Gameplay.HUD.Events 
{
	import flash.events.Event;
	import Gameplay.Player.Player;
	
	public class ScoreEvent extends Event
	{
		public static const ADJUST_SCORE_EVENT:String = "ADJUST_SCORE_EVENT";
		
		public var E_PlayerIndex:int;
		
		public var E_ScoreAdjustment:int;
		
		public function ScoreEvent(type:String, playerIndex:int, scoreAdjustment:int) 
		{
			super(type, false, false);
			
			E_PlayerIndex = playerIndex;
			
			E_ScoreAdjustment = scoreAdjustment;
		}	
	}
}