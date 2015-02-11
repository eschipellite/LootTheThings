package Menu 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_MenuShared
	{
		[Embed(source="../../content/Images/Menu/MenuShared/BackToMain.png")]
		public static var MenuShared_BackToMain:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(MenuShared_BackToMain, 2);
		}
	}
}