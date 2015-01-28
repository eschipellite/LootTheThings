package Utils.SoundContent 
{
	import flash.media.Sound;
	
	public class SoundLoader 
	{	
		public static function GetSound(soundClass:Class):Sound
		{	
			return (new soundClass) as Sound;
		}
	}
}