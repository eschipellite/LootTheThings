package Gameplay.Level 
{
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class RoomType 
	{
		private var m_RoomGrid:String;
		private var m_WaveInfo:XMLList;
		
		public function RoomType(roomGrid:String, waveInfo:XMLList) 
		{
			m_RoomGrid = roomGrid;
			m_WaveInfo = waveInfo;
		}
		
		public function get RoomGrid():String
		{
			return m_RoomGrid;
		}
		
		public function get WaveInfo():XMLList
		{
			return m_WaveInfo;
		}
	}
}