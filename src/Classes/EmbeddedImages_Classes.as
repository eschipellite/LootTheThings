package Classes 
{
	import Classes.Brigadier.EmbeddedImages_Brigadier;
	import Classes.Duelist.EmbeddedImages_Duelist;
	import Classes.Earthen.EmbeddedImages_Earthen;
	import Classes.Onslaught.EmbeddedImages_Onslaught;
	import Classes.Runner.EmbeddedImages_Runner;
	import Classes.Shade.EmbeddedImages_Shade;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Classes
	{		
		public static function LoadImages():void
		{
			EmbeddedImages_Brigadier.LoadImages();
			EmbeddedImages_Duelist.LoadImages();
			EmbeddedImages_Earthen.LoadImages();
			EmbeddedImages_Onslaught.LoadImages();
			EmbeddedImages_Runner.LoadImages();
			EmbeddedImages_Shade.LoadImages();
		}
	}
}