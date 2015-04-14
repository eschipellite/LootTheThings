package Classes.Onslaught 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Onslaught
	{		
		[Embed(source="../../../content/Images/Classes/Onslaught/Onslaught_Selection.png")]
		public static var Onslaught_Selection:Class;
		
		[Embed(source="../../../content/Images/Classes/Onslaught/Onslaught_Player.png")]
		public static var Onslaught_Player:Class;
		
		[Embed(source="../../../content/Images/Classes/Onslaught/Onslaught_Sword.png")]
		public static var Onslaught_Sword:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Onslaught_Selection);
			ImageLoader.InitializeImage(Onslaught_Player);
			ImageLoader.InitializeImage(Onslaught_Sword);
		}
	}
}