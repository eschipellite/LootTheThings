package Gameplay.HUD 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerHUD extends Sprite
	{
		private var m_PlayerTextField:TextField;
		private var m_ScoreTextField:TextField;
		
		private var m_PlayerIndex:int;
		private var m_PlayerNum:int;
		private var m_Score:int;
		
		private var m_TextOffset:int = 36;
		
		private var m_TextAlign:String;
		
		private var m_PositionOffset:Point;
		
		public function PlayerHUD() 
		{
			m_PlayerTextField = new TextField();
			m_ScoreTextField = new TextField();
			m_PlayerIndex = -1;
			m_PlayerNum = -1;
			m_Score = 0;
			m_PositionOffset = new Point(0, 0);
		}
		
		public function Initialize(playerIndex:int):void
		{
			m_PlayerIndex = playerIndex;
			m_PlayerNum = m_PlayerIndex + 1;
			
			setTextFieldPlacements();
			
			createPlayerTextField();
			
			createScoreTextField();
			
			this.addChild(m_PlayerTextField);
			this.addChild(m_ScoreTextField);
		}
		
		private function setTextFieldPlacements():void
		{
			switch(m_PlayerIndex)
			{
				case 0:
					m_TextAlign = TextFormatAlign.LEFT;
					break;
				case 1:
					m_TextAlign = TextFormatAlign.RIGHT;
					break;
				case 2:
					m_TextAlign = TextFormatAlign.RIGHT;
					m_PositionOffset.y = 512;
					break;
				case 3:
					m_TextAlign = TextFormatAlign.LEFT;
					m_PositionOffset.y = 512;
					break;
			}
		}
		
		private function createPlayerTextField():void
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 36;
			textFormat.align = m_TextAlign;
			
			m_PlayerTextField.defaultTextFormat = textFormat;
			m_PlayerTextField.width = Main.ScreenArea.x;
			
			m_PlayerTextField.wordWrap = true;
			m_PlayerTextField.selectable = false;
			
			m_PlayerTextField.x += m_PositionOffset.x;
			m_PlayerTextField.y += m_PositionOffset.y;
		}
		
		private function createScoreTextField():void
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 24;
			textFormat.align = m_TextAlign;
			
			m_ScoreTextField.defaultTextFormat = textFormat;
			m_ScoreTextField.width = Main.ScreenArea.x;
			
			m_ScoreTextField.wordWrap = true;
			m_ScoreTextField.selectable = false;
			
			m_ScoreTextField.x += m_PositionOffset.x;
			m_ScoreTextField.y += (m_PositionOffset.y + m_TextOffset);
		}
		
		private function refreshScore():void
		{
			m_PlayerTextField.text = "Player " + m_PlayerNum;
			m_ScoreTextField.text = "Score: " + m_Score;
		}
		
		public function Update():void
		{
			refreshScore();
		}
		
		public function AdjustScore(scoreAdjustment:int):void
		{
			m_Score += scoreAdjustment;
		}
		
		public function get Index():int
		{
			return m_PlayerIndex;
		}
		
		public function get Score():int
		{
			return m_Score;
		}
		
		public function get PlayerNum():int
		{
			return m_PlayerNum;
		}
	}
}