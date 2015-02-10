package Menu.Main 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Main
	{
		[Embed(source="../../../content/Images/Menu/Main/Background.png")]
		public static var Main_Background:Class;
		
		[Embed(source = "../../../content/Images/Menu/Main/Exit.png")]
		public static var Main_Exit:Class;
		
		[Embed(source = "../../../content/Images/Menu/Main/Options.png")]
		public static var Main_Options:Class;
		
		[Embed(source = "../../../content/Images/Menu/Main/Play.png")]
		public static var Main_Play:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Main_Background);
			ImageLoader.InitializeImage(Main_Exit, 2);
			ImageLoader.InitializeImage(Main_Options, 2);
			ImageLoader.InitializeImage(Main_Play, 2);
		}
	}
}