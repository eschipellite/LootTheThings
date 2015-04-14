package Classes.Shade 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Shade
	{		
		[Embed(source="../../../content/Images/Classes/Shade/Shade_Selection.png")]
		public static var Shade_Selection:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Shade_Selection);
		}
	}
}