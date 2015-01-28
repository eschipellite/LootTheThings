package General.LocalData 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.registerClassAlias;
	import flash.net.SharedObject;
	import General.LocalData.Events.LoadEvent;
	import General.Statistics.Statistics;
	import General.Statistics.StatisticsHandler;
	import Utils.GameTime;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class LocalData 
	{
		private static var g_eventDispatcher:IEventDispatcher = new EventDispatcher();
		
		private static var ms_SavedObject:SharedObject;
		
		private static var ms_CurrentTime:Number = 0;
		private static var ms_SaveTime:Number = 10;
		
		public static function SetClassAliases():void
		{
			registerClassAlias("Statistics", Statistics);
		}
		
		public static function Load():void
		{
			ms_SavedObject = SharedObject.getLocal("SavedData");
			
			eventDispatcher.dispatchEvent(new LoadEvent(LoadEvent.LOAD_STATISTICS_EVENT));
			eventDispatcher.dispatchEvent(new LoadEvent(LoadEvent.LOAD_EVENT));
			
			Save();
		}
		
		public static function Save():void
		{
			StatisticsHandler.SetStatistics();
			
			ms_SavedObject.flush();
		}
		
		public static function CheckSavedVariable(variable:String):Boolean
		{
			return ms_SavedObject.data.hasOwnProperty(variable);
		}
		
		public static function Update():void
		{
			ms_CurrentTime += GameTime.ElapsedGameTimeSeconds;
			
			if (ms_CurrentTime >= ms_SaveTime)
			{
				ms_CurrentTime -= ms_SaveTime;
				
				Save();
			}
		}
		
		public static function get SavedObject():SharedObject
		{
			return ms_SavedObject;
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return g_eventDispatcher;
		}
	}
}