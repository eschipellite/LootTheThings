package Utils 
{
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class GameTime 
	{			
		private static var m_ElapsedGameTime:Number;
		
		private static var m_PreviousTime:Number;
		
		public static function InitializeGameTime():void
		{
			m_ElapsedGameTime = 0;
			
			m_PreviousTime = getTimer();
		}
		
		public static function Update():void
		{
			var currentTime:int = getTimer();
			
			m_ElapsedGameTime = currentTime - m_PreviousTime;
			
			m_PreviousTime = currentTime;
		}
		
		public static function get ElapsedGameTimeMilliseconds():Number
		{
			return m_ElapsedGameTime;
		}
		
		public static function get ElapsedGameTimeSeconds():Number
		{
			return m_ElapsedGameTime / 1000;
		}
	}
}