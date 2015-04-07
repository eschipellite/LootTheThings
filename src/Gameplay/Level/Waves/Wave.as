package Gameplay.Level.Waves 
{
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class Wave 
	{
		private var m_NumEnemies:int;
		private var m_Duration:Number;
		
		public function Wave(numEnemies:int, duration:Number) 
		{
			m_NumEnemies = numEnemies;
			m_Duration = duration;
		}
		
		public function get NumEnemies():int
		{
			return m_NumEnemies;
		}
		
		public function get Duration():Number
		{
			return m_Duration;
		}
	}
}