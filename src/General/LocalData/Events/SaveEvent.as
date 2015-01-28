package General.LocalData.Events 
{
	import flash.events.Event;
	import Utils.ImageContent.Image;
	
	public class SaveEvent extends Event
	{
		public static const SAVE_EVENT:String = "SAVE_EVENT";
		
		public function SaveEvent(type:String) 
		{
			super(type, false, false);
		}	
	}
}