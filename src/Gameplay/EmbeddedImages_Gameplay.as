package Gameplay 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Gameplay
	{
		[Embed(source="../../content/Images/Gameplay/Background.png")]
		public static var Gameplay_Background:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Gameplay_Background);
		}
	}
}