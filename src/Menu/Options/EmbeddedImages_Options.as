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
		
		[Embed(source = "../../../content/Images/Menu/Options/BackToMain.png")]
		public static var Options_BackToMain:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Options_Background);
			ImageLoader.InitializeImage(Options_BackToMain, 2);
		}
	}
}