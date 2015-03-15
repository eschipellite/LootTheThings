package Menu.PlayerSelection 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import General.States.StateEvent;
	import General.States.StateHandler;
	import General.States.StateValues;
	import Menu.PlayerSelection.Events.LevelSelectorEvent;
	import Menu.PlayerSelection.Events.PlayerInformationEvent;
	import Menu.PlayerSelection.Events.PlayerSelectorEvent;
	import Utils.InputContent.Controllers.ControllerInput;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerSelector extends Sprite
	{
		private var m_PlayerInformation:Vector.<PlayerInformation>;
		
		private var m_PlayerInformationStart:Point = new Point(64, 192);
		private var m_PlayerInformationOffset:Point = new Point(288, 0);
		
		public function PlayerSelector() 
		{
			m_PlayerInformation = new Vector.<PlayerInformation>();
		}
		
		public function Initialize():void
		{
			for (var index:int = 0; index < Main.MaxPlayers; index++)
			{
				m_PlayerInformation.push(new PlayerInformation(index));
			}
			
			createPlayerInformation();
		}
		
		public function InitializeEventListeners():void
		{
			State_PlayerSelection.eventDispatcher.addEventListener(PlayerSelectorEvent.LEAVE_PLAYER_SELECTION_EVENT, eh_LeavePlayerSelection);
		}
		
		private function eh_LeavePlayerSelection(evt:PlayerSelectorEvent):void
		{
			State_PlayerSelection.eventDispatcher.dispatchEvent(new PlayerInformationEvent(PlayerInformationEvent.SEND_PLAYER_INFORMATION_EVENT, m_PlayerInformation));
			State_PlayerSelection.eventDispatcher.dispatchEvent(new LevelSelectorEvent(LevelSelectorEvent.LEAVE_LEVEL_SELECTION_EVENT));
			StateHandler.eventDispatcher.dispatchEvent(new StateEvent(StateEvent.MOVE_TO_STATE_EVENT, StateValues.STATE_GAMEPLAY));
		}
		
		private function createPlayerInformation():void
		{
			var position:Point = new Point(m_PlayerInformationStart.x, m_PlayerInformationStart.y);
			var offset:Point = new Point(m_PlayerInformationOffset.x, m_PlayerInformationOffset.y);
			for each(var playerInformation:PlayerInformation in m_PlayerInformation)
			{
				playerInformation.SetPosition(position);
				this.addChild(playerInformation);
				
				position = new Point(m_PlayerInformationStart.x + offset.x, m_PlayerInformationStart.y + offset.y);
				offset.x += m_PlayerInformationOffset.x;
				offset.y += m_PlayerInformationOffset.y;
			}
		}
		
		public function Update():void
		{
			for each(var playerInformation:PlayerInformation in m_PlayerInformation)
			{
				playerInformation.Update();
			}
		}
		
		public function Reset():void
		{
			for each(var playerInformation:PlayerInformation in m_PlayerInformation)
			{
				playerInformation.Reset();
			}
		}
	}
}