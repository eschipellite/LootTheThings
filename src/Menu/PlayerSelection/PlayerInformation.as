package Menu.PlayerSelection 
{
	import Classes.ClassTypes;
	import Classes.Onslaught.EmbeddedImages_Onslaught;
	import flash.display.Sprite;
	import flash.geom.Point;
	import Gameplay.State_Gameplay;
	import General.States.StateEvent;
	import General.States.StateHandler;
	import General.States.StateValues;
	import Menu.PlayerSelection.Events.LevelSelectorEvent;
	import Menu.PlayerSelection.Events.PlayerSelectorEvent;
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
		private var m_DisconnectedImage:Image;
		private var m_PlayerReadyImage:Image;
		private var m_ClassSelections:Vector.<ClassSelection>;
		
		private var m_Index:int;
		private var m_ConnectionState:int;
		private var m_ClassSelectionIndex:int;
		
		public function PlayerInformation() 
		{
			m_Index = 0;
			m_ConnectionState = ConnectionState.NOT_CONNECTED;
			m_ClassSelectionIndex = 0;
			
			m_ClassSelections = new Vector.<ClassSelection>();
		}
		
		public function Initialize(index:int):void
		{
			m_Index = index;
			
			m_DisconnectedImage = ImageLoader.GetImage(EmbeddedImages_PlayerSelection.PlayerSelection_ControllerDisconnected);
			m_PlayerReadyImage = ImageLoader.GetImage(EmbeddedImages_PlayerSelection.PlayerSelection_PlayerReady);
			
			addClassSelections();
			
			this.addChild(m_DisconnectedImage);
		}
		
		private function addClassSelections():void
		{
			for (var index:int = 0; index < ClassTypes.TOTAL_CLASS_TYPES; index++)
			{
				var classSelection:ClassSelection = new ClassSelection();
				classSelection.Initialize(index);
				m_ClassSelections.push(classSelection);
			}
		}
		
		public function Update():void
		{
			checkConnected();
			checkJoin();
			checkReturn();
			checkLevelSelection();
			checkClassSelection();
			
			refreshImage();
		}
		
		private function refreshImage():void
		{
			switch(m_ConnectionState)
			{
				case ConnectionState.NOT_CONNECTED:
					refreshDisconnected();
					break;
				case ConnectionState.CONNECTED:
					refreshConnected();
					break;
				case ConnectionState.READY:
					refreshReady();
					break;
			}
		}
		
		private function removeDisconnected():void
		{
			if (this.contains(m_DisconnectedImage))
			{
				this.removeChild(m_DisconnectedImage);
			}
		}
		
		private function removeCurrentClassSelection():void
		{
			if (this.contains(m_ClassSelections[m_ClassSelectionIndex]))
			{
				this.removeChild(m_ClassSelections[m_ClassSelectionIndex]);
			}
		}
		
		private function removeReady():void
		{
			if (this.contains(m_PlayerReadyImage))
			{
				this.removeChild(m_PlayerReadyImage);
			}
		}
		
		private function refreshDisconnected():void
		{
			removeCurrentClassSelection();
			removeReady();
			
			this.addChild(m_DisconnectedImage);
		}
		
		private function refreshConnected():void
		{
			removeDisconnected();
			removeReady();
			
			this.addChild(m_ClassSelections[m_ClassSelectionIndex]);
		}
		
		private function refreshReady():void
		{
			removeDisconnected();
			
			this.addChild(m_PlayerReadyImage);
		}
		
		public function Reset():void
		{
			m_ConnectionState = ConnectionState.NOT_CONNECTED;
			
			refreshImage();
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
			if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.BUTTON_A))
			{
				switch(m_ConnectionState)
				{
					case ConnectionState.CONNECTED:
						m_ConnectionState = ConnectionState.READY;
						break;
					case ConnectionState.READY:
						State_PlayerSelection.eventDispatcher.dispatchEvent(new PlayerSelectorEvent(PlayerSelectorEvent.LEAVE_PLAYER_SELECTION_EVENT));
						break;
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
		
		private function checkLevelSelection():void
		{
			if (m_ConnectionState != ConnectionState.NOT_CONNECTED)
			{
				var direction:Point = new Point(0, 0);
				
				if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.DPAD_UP)) 
				{
					direction.y++;
				}
				
				if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.DPAD_DOWN)) 
				{
					direction.y--;
				}
				
				if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.DPAD_RIGHT)) 
				{
					direction.x++;
				}
				
				if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.DPAD_LEFT)) 
				{
					direction.x--;
				}
				
				State_PlayerSelection.eventDispatcher.dispatchEvent(new LevelSelectorEvent(LevelSelectorEvent.ADJUST_ROOM_NUMBER_EVENT, -direction.y));
				State_PlayerSelection.eventDispatcher.dispatchEvent(new LevelSelectorEvent(LevelSelectorEvent.ADJUST_DIVERGENCE_EVENT, direction.x));
			}
		}
		
		private function checkClassSelection():void
		{
			if (m_ConnectionState == ConnectionState.CONNECTED)
			{
				var direction:int = 0;
				
				if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.LEFT_STICK_UP)) 
				{
					direction++;
				}
				
				if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.LEFT_STICK_DOWN)) 
				{
					direction--;
				}
				
				adjustClassSelection(direction);
			}
		}
		
		private function adjustClassSelection(adjustment:int):void
		{
			removeCurrentClassSelection();
			
			m_ClassSelectionIndex += adjustment;
			
			if (m_ClassSelectionIndex < 0)
			{
				m_ClassSelectionIndex = m_ClassSelections.length - 1;
			}
			else if (m_ClassSelectionIndex > m_ClassSelections.length -1)
			{
				m_ClassSelectionIndex = 0;
			}
			
			this.addChild(m_ClassSelections[m_ClassSelectionIndex]);
		}
		
		public function get InGame():Boolean
		{
			return m_ConnectionState == ConnectionState.READY;
		}
		
		public function get Index():int
		{
			return m_Index;
		}
		
		public function get ClassType():int
		{
			return m_ClassSelections[m_ClassSelectionIndex].ClassType;
		}
	}
}