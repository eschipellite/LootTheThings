package Gameplay.HUD 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_HUD
	{
		[Embed(source="../../../content/Images/Gameplay/HUD/HUD_Background.png")]
		public static var HUD_Background:Class;
		
		[Embed(source = "../../../content/Images/Gameplay/HUD/HUD_Map_Background.png")]
		public static var HUD_Map_Background:Class;
		
		[Embed(source = "../../../content/Images/Gameplay/HUD/HUD_Map_Nodes.png")]
		public static var HUD_Map_Nodes:Class;
		
		[Embed(source = "../../../content/Images/Gameplay/HUD/HUD_Return.png")]
		public static var HUD_Return:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(HUD_Background, 4);
			ImageLoader.InitializeImage(HUD_Map_Background);
			ImageLoader.InitializeImage(HUD_Map_Nodes, 3);
			ImageLoader.InitializeImage(HUD_Return);
		}
	}
}