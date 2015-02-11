package Gameplay.Collectibles 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Collectibles
	{
		[Embed(source="../../../content/Images/Gameplay/Collectibles/Star.png")]
		public static var Gameplay_Star:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Gameplay_Star);
		}
	}
}