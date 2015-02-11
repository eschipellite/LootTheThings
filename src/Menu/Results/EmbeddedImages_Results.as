package Menu.Results 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Results
	{
		[Embed(source="../../../content/Images/Menu/Results/Background.png")]
		public static var Results_Background:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Results_Background);
		}
	}
}