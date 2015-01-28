package General.Statistics 
{
	import flash.utils.Dictionary;
	import General.LocalData.Events.LoadEvent;
	import General.LocalData.LocalData;
	import General.Statistics.StatisticsTypes.Statistics_Gameplay;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class StatisticsHandler 
	{
		private static var s_Statistics:Dictionary = new Dictionary();
		
		public static function CreateStatistics():void
		{
			s_Statistics[Statistics_Keys.STATISTICS_GAMEPLAY] = new Statistics_Gameplay();
		}
		
		public static function InitializeEventListeners():void
		{
			LocalData.eventDispatcher.addEventListener(LoadEvent.LOAD_STATISTICS_EVENT, eh_LoadStatistics);
		}
		
		private static function eh_LoadStatistics(evt:LoadEvent):void
		{
			for (var key:String in s_Statistics)
			{
				if (LocalData.CheckSavedVariable(key))
				{
					s_Statistics[key] = LocalData.SavedObject.data[key];
				}
				else
				{
					LocalData.SavedObject.data[key] = s_Statistics[key];
				}
			}
		}
		
		public static function SetStatistics():void
		{
			for (var key:String in s_Statistics)
			{
				LocalData.SavedObject.data[key] = s_Statistics[key];
			}
		}
		
		public static function GetStatistics(key:String):Statistics
		{
			return s_Statistics[key];
		}
	}
}