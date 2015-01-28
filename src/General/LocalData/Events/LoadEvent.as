package General.LocalData.Events 
{
	import flash.events.Event;
	import Utils.ImageContent.Image;
	
	public class LoadEvent extends Event
	{
		public static const LOAD_EVENT:String = "LOAD_EVENT";
		public static const LOAD_STATISTICS_EVENT:String = "LOAD_STATISTICS_EVENT";
		
		public function LoadEvent(type:String) 
		{
			super(type, false, false);
		}	
	}
}