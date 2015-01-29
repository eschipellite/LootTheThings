package Utils.Output 
{
	import Utils.GameTime;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class ConsoleLine 
	{
		private var m_Text:String;
		
		private var m_Duration:Number;
		
		private var m_ShouldRemove:Boolean;
		
		public function ConsoleLine(text:String, duration:Number) 
		{
			m_Text = text;
			
			m_Duration = duration;
			
			m_ShouldRemove = false;
		}
		
		public function Update():void
		{
			if (!m_ShouldRemove)
			{
				checkDuration();
			}
		}
		
		private function checkDuration():void
		{
			m_Duration -= GameTime.ElapsedGameTimeSeconds;
			
			if (m_Duration <= 0)
			{
				m_Duration = 0;
				
				m_ShouldRemove = true;
			}
		}
		
		public function get Text():String
		{
			return m_Text;
		}
		
		public function get ShouldRemove():Boolean
		{
			return m_ShouldRemove;
		}
	}
}