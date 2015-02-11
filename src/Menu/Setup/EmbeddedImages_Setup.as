package Menu.Setup 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Setup
	{
		[Embed(source="../../../content/Images/Menu/Setup/Background.png")]
		public static var Setup_Background:Class;
		
		[Embed(source = "../../../content/Images/Menu/Setup/NewGame.png")]
		public static var Setup_NewGame:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Setup_Background);
			ImageLoader.InitializeImage(Setup_NewGame, 2);
		}
	}
}