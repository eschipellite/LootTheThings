package Utils.SoundContent 
{
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class SoundHandler 
	{
		private static var m_SoundHolders:Dictionary = new Dictionary();
		
		public static function AddSound(soundName:String, soundClass:Class, resetOnPlay:Boolean = true):void
		{
			m_SoundHolders[soundName] = new SoundHolder(soundName, soundClass, resetOnPlay);
		}
		
		public static function ClearAllSounds():void
		{
			for each(var sound:SoundHolder in m_SoundHolders)
			{
				sound.Stop();
			}
			
			m_SoundHolders = new Dictionary();
		}
		
		public static function PlaySound(soundName:String, loop:Boolean = false, volume:Number = 1):void
		{
			if (m_SoundHolders[soundName].ResetOnPlay)
			{
				m_SoundHolders[soundName].Stop();
				
				m_SoundHolders[soundName].Play(loop, volume);
			}
			else
			{
				if (!m_SoundHolders[soundName].IsPlaying)
				{
					m_SoundHolders[soundName].Play(loop, volume);	
				}
			}
		}
		
		public static function StopSound(soundName:String):void
		{
			m_SoundHolders[soundName].Stop();
		}
		
		public static function RemoveSound(soundName:String):void
		{
			if (m_SoundHolders[soundName])
			{
				m_SoundHolders[soundName].Stop();
				
				delete m_SoundHolders[soundName];
			}
		}
	}

}