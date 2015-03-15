package Menu.PlayerSelection 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import Menu.PlayerSelection.Events.LevelSelectorEvent;
	import Menu.PlayerSelection.Events.PlayerSelectorEvent;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class LevelSelector extends Sprite
	{
		private var m_RoomNumSelector:TextField;
		private var m_RoomNum:int;
		private const m_MinRoomNum:int = 1;
		private const m_MaxRoomNum:int = 50;
		private var m_Position_RoomNumSelector:Point = new Point(0, 32);
		
		private var m_DivergenceSelector:TextField;
		private var m_Divergence:int;
		private const m_MinDivergence:int = 1;
		private const m_MaxDivergence:int = 50;
		private var m_Position_DivergenceSelector:Point = new Point(0, 64);
		
		public function LevelSelector() 
		{
			m_RoomNumSelector = new TextField();
			m_DivergenceSelector = new TextField();
		}
		
		public function Initialize():void
		{
			createRoomNumSelector();
			createDivergenceSelector();
			
			this.addChild(m_RoomNumSelector);
			this.addChild(m_DivergenceSelector);
		}
		
		public function InitializeEventListeners():void
		{
			State_PlayerSelection.eventDispatcher.addEventListener(LevelSelectorEvent.ADJUST_ROOM_NUMBER_EVENT, eh_AdjustRoomNumber);
			State_PlayerSelection.eventDispatcher.addEventListener(LevelSelectorEvent.ADJUST_DIVERGENCE_EVENT, eh_AdjustDivergence);
			State_PlayerSelection.eventDispatcher.addEventListener(LevelSelectorEvent.LEAVE_LEVEL_SELECTION_EVENT, eh_LeavePlayerSelection);
		}
		
		private function eh_AdjustRoomNumber(evt:LevelSelectorEvent):void
		{
			m_RoomNum += evt.E_Adjustment;
			
			if (m_RoomNum < m_MinRoomNum)
			{
				m_RoomNum = m_MinRoomNum;
			}
			
			if (m_RoomNum > m_MaxRoomNum)
			{
				m_RoomNum = m_MaxRoomNum;
			}
		}
		
		private function eh_AdjustDivergence(evt:LevelSelectorEvent):void
		{
			m_Divergence += evt.E_Adjustment;
			
			if (m_Divergence < m_MinDivergence)
			{
				m_Divergence = m_MinDivergence;
			}
			
			if (m_Divergence > m_MaxDivergence)
			{
				m_Divergence = m_MaxDivergence;
			}
		}
		
		private function eh_LeavePlayerSelection(evt:LevelSelectorEvent):void
		{
			State_PlayerSelection.eventDispatcher.dispatchEvent(new LevelSelectorEvent(LevelSelectorEvent.SET_LEVEL_INFORMATION_EVENT, 0, m_RoomNum, m_Divergence));
		}
		
		public function Update():void
		{
			refresh();
		}
		
		private function refresh():void
		{
			m_RoomNumSelector.text = "Number of Rooms: " + m_RoomNum;
			m_DivergenceSelector.text = "Divergence: " + m_Divergence;
		}
		
		public function Reset():void
		{
		}
		
		private function createRoomNumSelector():void
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 36;
			textFormat.color = 0x000000;
			
			m_RoomNumSelector.defaultTextFormat = textFormat;
			m_RoomNumSelector.width = Main.ScreenArea.x;
			
			m_RoomNumSelector.wordWrap = true;
			m_RoomNumSelector.selectable = false;
			
			m_RoomNumSelector.x = m_Position_RoomNumSelector.x;
			m_RoomNumSelector.y = m_Position_RoomNumSelector.y;
		}
		
		private function createDivergenceSelector():void
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 36;
			textFormat.color = 0x000000;
			
			m_DivergenceSelector.defaultTextFormat = textFormat;
			m_DivergenceSelector.width = Main.ScreenArea.x;
			
			m_DivergenceSelector.wordWrap = true;
			m_DivergenceSelector.selectable = false;
			
			m_DivergenceSelector.x = m_Position_DivergenceSelector.x;
			m_DivergenceSelector.y = m_Position_DivergenceSelector.y;
		}
	}
}