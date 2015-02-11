package Menu.Options 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Options
	{
		[Embed(source="../../../content/Images/Menu/Options/Background.png")]
		public static var Options_Background:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Options_Background);
		}
	}
}