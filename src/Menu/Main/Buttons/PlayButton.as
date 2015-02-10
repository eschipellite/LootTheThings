package Menu.Main.Buttons 
{
	import General.States.StateEvent;
	import General.States.StateHandler;
	import General.States.StateValues;
	import Menu.Main.EmbeddedImages_Main;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayButton extends MenuButton
	{
		public function PlayButton() 
		{
			m_ImageClass = EmbeddedImages_Main.Main_Play;
		}
		
		override public function DoAction():void
		{
			StateHandler.eventDispatcher.dispatchEvent(new StateEvent(StateEvent.MOVE_TO_STATE_EVENT, StateValues.STATE_SETUP));
		}
	}
}