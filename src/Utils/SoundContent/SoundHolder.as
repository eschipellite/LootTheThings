package Utils.SoundContent 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class SoundHolder 
	{
		private var m_Name:String;
		
		private var m_SoundChannel:SoundChannel; 
		private var m_Sound:Sound;
		
		private var m_Volume:Number;
		
		private var m_IsPlaying:Boolean;
		private var m_ResetOnPlay:Boolean;
		
		public function SoundHolder(soundName:String, soundClass:Class, resetOnPlay:Boolean) 
		{
			m_IsPlaying = false;
			m_ResetOnPlay = resetOnPlay;
			
			m_Volume = 1;
			
			m_Name = soundName;
			
			m_SoundChannel = new SoundChannel();
			m_Sound = (new soundClass) as Sound;
		}	
		
		public function Play(loop:Boolean = false, volume:Number = 1):void
		{	
			m_Volume = volume;
			
			m_IsPlaying = true;
			
			var soundTransform:SoundTransform = new SoundTransform(m_Volume);
			
			m_SoundChannel = m_Sound.play(0, 0, soundTransform);
			
			if (loop)
			{
				m_SoundChannel.addEventListener(Event.SOUND_COMPLETE, onComplete);
			}
		}
		
		public function Stop():void
		{
			if (m_Sound.hasEventListener(Event.SOUND_COMPLETE))
			{
				m_SoundChannel.removeEventListener(Event.SOUND_COMPLETE, onComplete);
			}
			
			m_SoundChannel.stop();
			
			m_IsPlaying = false;
		}
		
		private function onComplete(evt:Event):void
		{
			m_SoundChannel.removeEventListener(Event.SOUND_COMPLETE, onComplete);
			
			Play(true, m_Volume);
		}
		
		public function get IsPlaying():Boolean
		{
			return m_IsPlaying;
		}
		
		public function get ResetOnPlay():Boolean
		{
			return m_ResetOnPlay;
		}
	}
}