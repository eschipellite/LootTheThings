package Gameplay.HUD 
{
	import flash.display.Sprite;
	import Gameplay.HUD.Events.EndGameEvent;
	import Gameplay.HUD.Events.ScoreEvent;
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
		}
		
		public function Update():void
		{
			for each(var playerHUD:PlayerHUD in m_PlayerHUDs)
			{
				playerHUD.Update();
			}
			
			checkScore();
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