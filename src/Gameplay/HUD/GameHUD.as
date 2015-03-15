package Gameplay.HUD 
{
	import flash.display.Sprite;
	import Gameplay.HUD.Events.EndGameEvent;
	import Gameplay.HUD.Events.RoomInfoEvent;
	import Gameplay.HUD.Events.ScoreEvent;
	import Gameplay.HUD.Events.HUDEvent;
	import Gameplay.Level.Events.RoomEvent;
	import Gameplay.Level.RoomInfo;
	import Gameplay.Player.Player;
	import Gameplay.State_Gameplay;
	import General.States.StateEvent;
	import General.States.StateHandler;
	import General.States.StateValues;
	import Menu.PlayerSelection.Events.PlayerInformationEvent;
	import Menu.PlayerSelection.PlayerInformation;
	import Menu.Results.State_Results;
	/**
	 * ...
	 * @author ...
	 */
	public class GameHUD extends Sprite
	{
		private var m_PlayerHUDs:Vector.<PlayerHUD>;
		
		private var m_TargetScore:int = 100;
		
		public function GameHUD() 
		{
			m_PlayerHUDs = new Vector.<PlayerHUD>();
		}
		
		public function Initialize():void
		{
			
		}
		
		public function InitializeEventListeners():void
		{
			State_Gameplay.eventDispatcher.addEventListener(ScoreEvent.ADJUST_SCORE_EVENT, eh_AdjustScore);
			State_Gameplay.eventDispatcher.addEventListener(HUDEvent.TOGGLE_HUD_EVENT, eh_ToggleHUD);
			State_Gameplay.eventDispatcher.addEventListener(HUDEvent.TOGGLE_RETURN_EVENT, eh_ToggleReturn);
			State_Gameplay.eventDispatcher.addEventListener(RoomInfoEvent.SEND_ALL_ROOM_INFORMATION_EVENT, eh_GetAllRoomInformation);
			State_Gameplay.eventDispatcher.addEventListener(RoomInfoEvent.SEND_ROOM_INFO_EVENT, eh_GetRoomInfo);
			State_Gameplay.eventDispatcher.addEventListener(RoomEvent.CHANGE_ROOM_EVENT, eh_ChangeRoom);
		}
		
		private function eh_ToggleHUD(evt:HUDEvent):void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				if (playerHUD.Index == evt.E_PlayerIndex)
				{
					playerHUD.ToggleHUD();
				}
			}
		}
		
		private function eh_ToggleReturn(evt:HUDEvent):void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				if (playerHUD.Index == evt.E_PlayerIndex)
				{
					playerHUD.ToggleReturn();
				}
			}
		}
		
		private function eh_GetAllRoomInformation(evt:RoomInfoEvent):void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				playerHUD.SetRoomInformation(evt.E_RoomInformation);
			}
		}
		
		private function eh_GetRoomInfo(evt:RoomInfoEvent):void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				playerHUD.SetRoomInfo(evt.E_RoomInfo);
			}
		}
		
		private function eh_ChangeRoom(evt:RoomEvent):void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				playerHUD.ChangeRoom(evt.E_Exit);
			}
		}
		
		public function Update():void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				playerHUD.Update();
			}
			
			checkScore();
			checkReturn();
		}
		
		private function checkReturn():void
		{
			var shouldReturn:Boolean = true;
			
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				if (!playerHUD.ShouldReturn)
				{
					shouldReturn = false;
				}
			}
			
			if (shouldReturn)
			{
				StateHandler.eventDispatcher.dispatchEvent(new StateEvent(StateEvent.MOVE_TO_STATE_EVENT, StateValues.STATE_PLAYERSELECTION));
			}
		}
		
		public function Begin():void
		{
			createPlayerHUDs();
		}
		
		public function Leave():void
		{
			removePlayerHUDs();
		}
		
		private function checkScore():void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				if (playerHUD.Score >= m_TargetScore)
				{
					State_Results.eventDispatcher.dispatchEvent(new EndGameEvent(EndGameEvent.SET_WINNER_EVENT, playerHUD.PlayerNum));
					StateHandler.eventDispatcher.dispatchEvent(new StateEvent(StateEvent.MOVE_TO_STATE_EVENT, StateValues.STATE_RESULTS));
					break;
				}
			}
		}
		
		private function eh_AdjustScore(evt:ScoreEvent):void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				if (playerHUD.Index == evt.E_PlayerIndex)
				{
					playerHUD.AdjustScore(evt.E_ScoreAdjustment);
				}
			}
		}
		
		private function createPlayerHUDs():void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				//playerHUD.SetPosition(getRandomPlayerPosition(player.Size));
				this.addChild(playerHUD);
			}
		}
		
		private function removePlayerHUDs():void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				if (this.contains(playerHUD))
				{
					this.removeChild(playerHUD);
				}
			}
			
			m_PlayerHUDs = new Vector.<PlayerHUD>();
		}
		
		public function SetPlayerInformation(playerInformation:Vector.<PlayerInformation>):void
		{
			removePlayerHUDs();
			
			for each(var playerInfo:PlayerInformation in playerInformation)
			{
				if (playerInfo.InGame)
				{
					var playerHUD:PlayerHUD = new PlayerHUD();
					playerHUD.Initialize(playerInfo.Index);
					m_PlayerHUDs.push(playerHUD);
				}
			}
		}
	}
}