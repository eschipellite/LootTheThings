package Menu.PlayerSelection 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_PlayerSelection
	{
		[Embed(source="../../../content/Images/Menu/PlayerSelection/PlayerSelection_Background.png")]
		public static var PlayerSelection_Background:Class;
		
		[Embed(source = "../../../content/Images/Menu/PlayerSelection/PlayerSelection_ControllerDisconnected.png")]
		public static var PlayerSelection_ControllerDisconnected:Class;
		
		[Embed(source = "../../../content/Images/Menu/PlayerSelection/PlayerSelection_PlayerReady.png")]
		public static var PlayerSelection_PlayerReady:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(PlayerSelection_Background);
			ImageLoader.InitializeImage(PlayerSelection_ControllerDisconnected);
			ImageLoader.InitializeImage(PlayerSelection_PlayerReady);
		}
	}
}