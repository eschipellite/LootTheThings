package General.Embedded_Content 
{
	import Gameplay.EmbeddedImages_Gameplay;
	import Menu.Main.EmbeddedImages_Main;
	import Menu.Options.EmbeddedImages_Options;
	import Menu.PlayerSelection.EmbeddedImages_PlayerSelection;
	import Menu.EmbeddedImages_MenuShared;
	import Menu.Results.EmbeddedImages_Results;
	import Menu.Setup.EmbeddedImages_Setup;
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
			
			EmbeddedImages_MenuShared.LoadImages();
			EmbeddedImages_Main.LoadImages();
			EmbeddedImages_Gameplay.LoadImages();
			EmbeddedImages_Options.LoadImages();
			EmbeddedImages_Setup.LoadImages();
			EmbeddedImages_PlayerSelection.LoadImages();
			EmbeddedImages_Results.LoadImages();
		}
	}
}