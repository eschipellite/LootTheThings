package General.Embedded_Content 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_General
	{
		[Embed(source="../../../content/Images/General/General_Icon.png")]
		public static var General_Icon:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(General_Icon);
		}
	}
}