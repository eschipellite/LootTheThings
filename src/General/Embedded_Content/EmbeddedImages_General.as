package General.Embedded_Content 
{
	import Gameplay.EmbeddedImages_Gameplay;
	import Gameplay.Player.EmbeddedImages_Player;
	import Menu.Main.EmbeddedImages_Main;
	import Menu.Options.EmbeddedImages_Options;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_General
	{
		[Embed(source = "../../../content/Images/General/NullButton.png")]
		public static var General_NullButton:Class;
		
		public static function LoadImages():void
		{	
			ImageLoader.InitializeImage(General_NullButton, 2);
			
			EmbeddedImages_Main.LoadImages();
			EmbeddedImages_Gameplay.LoadImages();
			EmbeddedImages_Options.LoadImages();
			EmbeddedImages_Player.LoadImages();
		}
	}
}