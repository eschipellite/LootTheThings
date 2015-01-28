package General.Embedded_Content 
{
	import Utils.ImageContent.ImageLoader;
	import Utils.SoundContent.SoundHandler;
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class EmbeddedSounds_General
	{
		[Embed(source="../../../content/Sounds/General/General_Click.mp3")]
		private static var General_Click:Class;
		public static const GENERAL_CLICK:String = "SOUND_GENERAL_CLICK";
		
		public static function LoadSounds():void
		{
			SoundHandler.AddSound(GENERAL_CLICK, General_Click);
		}
	}

}