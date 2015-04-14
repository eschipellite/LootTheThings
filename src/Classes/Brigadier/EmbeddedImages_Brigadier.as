package Classes.Brigadier 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Brigadier
	{		
		[Embed(source="../../../content/Images/Classes/Brigadier/Brigadier_Selection.png")]
		public static var Brigadier_Selection:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Brigadier_Selection);
		}
	}
}