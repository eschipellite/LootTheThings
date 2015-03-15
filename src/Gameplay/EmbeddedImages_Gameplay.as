package Gameplay 
{
	import Gameplay.HUD.EmbeddedImages_HUD;
	import Gameplay.Player.EmbeddedImages_Player;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Gameplay
	{
		[Embed(source="../../content/Images/Gameplay/Background.png")]
		public static var Gameplay_Background:Class;
		
		[Embed(source="../../content/Images/Gameplay/Level/Tiles.png")]
		public static var Gameplay_Tiles:Class;	
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Gameplay_Background);
			ImageLoader.InitializeImage(Gameplay_Tiles, 2);
			
			EmbeddedImages_Player.LoadImages();
			EmbeddedImages_HUD.LoadImages();
		}
	}
}