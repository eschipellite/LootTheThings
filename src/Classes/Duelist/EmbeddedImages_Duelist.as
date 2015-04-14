package Classes.Duelist 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Duelist
	{		
		[Embed(source="../../../content/Images/Classes/Duelist/Duelist_Selection.png")]
		public static var Duelist_Selection:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Duelist_Selection);
		}
	}
}