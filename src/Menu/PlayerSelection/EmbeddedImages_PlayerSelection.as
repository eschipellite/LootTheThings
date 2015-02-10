package Menu.PlayerSelection 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_PlayerSelection
	{
		[Embed(source="../../../content/Images/Menu/PlayerSelection/Background.png")]
		public static var PlayerSelection_Background:Class;
		
		[Embed(source = "../../../content/Images/Menu/PlayerSelection/ControllerStatus.png")]
		public static var PlayerSelection_ControllerStatus:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(PlayerSelection_Background);
			ImageLoader.InitializeImage(PlayerSelection_ControllerStatus, 3);
		}
	}
}