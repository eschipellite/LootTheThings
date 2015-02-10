package Menu.Options.Butons 
{
	import General.States.StateEvent;
	import General.States.StateHandler;
	import General.States.StateValues;
	import Menu.Main.Buttons.MenuButton;
	import Menu.Options.EmbeddedImages_Options;
	/**
	 * ...
	 * @author ...
	 */
	public class BackToMainButton extends MenuButton
	{
		public function BackToMainButton() 
		{
			m_ImageClass = EmbeddedImages_Options.Options_BackToMain;
		}
		
		override public function DoAction():void
		{
			StateHandler.eventDispatcher.dispatchEvent(new StateEvent(StateEvent.MOVE_TO_STATE_EVENT, StateValues.STATE_MAIN));
		}
	}
}