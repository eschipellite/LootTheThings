package General.Embedded_Content 
{
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class EmbeddedFiles_General 
	{
		[Embed(source="../../../content/Files/Rooms.xml", mimeType = "application/octet-stream")]
		public static var General_Rooms:Class;
	}
}