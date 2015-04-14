package Classes.Runner 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Runner
	{		
		[Embed(source="../../../content/Images/Classes/Runner/Runner_Selection.png")]
		public static var Runner_Selection:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Runner_Selection);
		}
	}
}