package Gameplay 
{
	import Gameplay.HUD.EmbeddedImages_HUD;
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
		
		[Embed(source="../../content/Images/Gameplay/Player/Player.png")]
		public static var Gameplay_Player:Class;
		
		[Embed(source="../../content/Images/Gameplay/Enemy/Enemy.png")]
		public static var Gameplay_Enemy:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Gameplay_Background);
			ImageLoader.InitializeImage(Gameplay_Tiles, 2);
			ImageLoader.InitializeImage(Gameplay_Player, 4);
			ImageLoader.InitializeImage(Gameplay_Enemy);
			
			EmbeddedImages_HUD.LoadImages();
		}
	}
}