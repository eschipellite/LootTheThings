package Utils.InputContent.Controllers 
{
	import flash.ui.GameInputDevice;
	/**
	 * ...
	 * @author ...
	 */
	public class GameController 
	{
		private var m_GameInputDevice:GameInputDevice;
		
		public function GameController(gameInputDevice:GameInputDevice) 
		{
			m_GameInputDevice = gameInputDevice;
		}
		
		public function get Device():GameInputDevice
		{
			return m_GameInputDevice;
		}
	}
}