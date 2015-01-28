package General.Embedded_Content {
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class EmbeddedFonts_General 
	{
		[Embed(source="../../../content/Fonts/TLOZ_Phantom_Hourglass.ttf", fontName = "Font_Name_Hourglass", mimeType = "application/x-font", advancedAntiAliasing="true", embedAsCFF="false")]
		private static var Font_Hourglass:Class;
		public static var Font_Name_Hourglass:String = "Font_Name_Hourglass";
	}
}