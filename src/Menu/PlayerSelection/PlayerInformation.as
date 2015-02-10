package Menu.PlayerSelection 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import General.States.StateEvent;
	import General.States.StateHandler;
	import General.States.StateValues;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	import Utils.InputContent.Controllers.ControllerInput;
	import Utils.InputContent.Controllers.GameController;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerInformation extends Sprite
	{
		private var m_Image:Image;
		
		private var m_Index:int;
		
		private var m_ConnectionState:int;
		
		public function PlayerInformation(index:int) 
		{
			m_Index = index;
			m_ConnectionState = ConnectionState.NOT_CONNECTED;
			
			m_Image = ImageLoader.GetImage(EmbeddedImages_PlayerSelection.PlayerSelection_ControllerStatus);
			
			this.addChild(m_Image);
		}
		
		public function SetPosition(position:Point):void
		{
			m_Image.x = position.x;
			m_Image.y = position.y;
		}
		
		public function Update():void
		{
			checkConnected();
			
			checkJoin();
			
			checkReturn();
			
			refreshImage();
		}
		
		private function refreshImage():void
		{
			m_Image.Frame = m_ConnectionState;
		}
		
		public function Reset():void
		{
			m_ConnectionState = ConnectionState.NOT_CONNECTED;
		}
		
		private function checkConnected():void
		{
			var connected:Boolean = ControllerInput.GetController(m_Index).Connected;
			
			if (m_ConnectionState == ConnectionState.NOT_CONNECTED)
			{
				if (connected)
				{
					m_ConnectionState = ConnectionState.CONNECTED;
				}
			}
			else
			{
				if (!connected)
				{
					m_ConnectionState = ConnectionState.NOT_CONNECTED;
				}
			}
		}
		
		private function checkJoin():void
		{
			if (m_ConnectionState == ConnectionState.CONNECTED)
			{
				if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.BUTTON_A))
				{
					m_ConnectionState = ConnectionState.READY;
				}
			}
		}
		
		private function checkReturn():void
		{
			if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.BUTTON_D))
			{
				switch(m_ConnectionState)
				{
					case ConnectionState.CONNECTED:
						StateHandler.eventDispatcher.dispatchEvent(new StateEvent(StateEvent.MOVE_TO_STATE_EVENT, StateValues.STATE_SETUP));
						break;
					case ConnectionState.READY:
						m_ConnectionState = ConnectionState.CONNECTED;
						break;
				}
			}
		}
	}
}