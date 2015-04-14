package Classes.Earthen 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Earthen
	{		
		[Embed(source="../../../content/Images/Classes/Earthen/Earthen_Selection.png")]
		public static var Earthen_Selection:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Earthen_Selection);
		}
	}
}