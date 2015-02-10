package Menu.Setup.Buttons 
{
	import General.States.StateEvent;
	import General.States.StateHandler;
	import General.States.StateValues;
	import Menu.Main.Buttons.MenuButton;
	import Menu.Setup.EmbeddedImages_Setup;
	/**
	 * ...
	 * @author ...
	 */
	public class NewGameButton extends MenuButton
	{
		public function NewGameButton() 
		{
			m_ImageClass = EmbeddedImages_Setup.Setup_NewGame;
		}	
		
		override public function DoAction():void
		{
			StateHandler.eventDispatcher.dispatchEvent(new StateEvent(StateEvent.MOVE_TO_STATE_EVENT, StateValues.STATE_PLAYERSELECTION));
		}
	}
}