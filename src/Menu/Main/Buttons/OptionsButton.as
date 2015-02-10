package Menu.Main.Buttons 
{
	import General.States.StateEvent;
	import General.States.StateHandler;
	import General.States.StateValues;
	import Menu.Main.EmbeddedImages_Main;
	/**
	 * ...
	 * @author ...
	 */
	public class OptionsButton extends MenuButton
	{
		public function OptionsButton() 
		{
			m_ImageClass = EmbeddedImages_Main.Main_Options;
		}	
		
		override public function DoAction():void
		{
			StateHandler.eventDispatcher.dispatchEvent(new StateEvent(StateEvent.MOVE_TO_STATE_EVENT, StateValues.STATE_OPTIONS));
		}
	}
}