package Gameplay.HUD.PlayerInfo 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import Gameplay.HUD.EmbeddedImages_HUD;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class PlayerInfo extends Sprite
	{
		private var m_Return:Image;
		private var m_Offset_Return:Point = new Point(0, 8);
		
		private var m_PlayerTextField:TextField;
		private var m_ScoreTextField:TextField;
		
		private var m_PlayerIndex:int;
		private var m_PlayerNum:int;
		private var m_Score:int;
		
		private var m_TextOffset:int = 36;
		
		private var m_TextAlign:String;
		
		private var m_Offset:Point;
		
		private var m_BackgroundBounds:Rectangle;
		
		public function PlayerInfo() 
		{
			m_PlayerTextField = new TextField();
			m_ScoreTextField = new TextField();
			
			m_Offset = new Point(0, 0);
			m_Score = 0;
		}
		
		public function Initialize(playerIndex:int, playerNum:int, background:Rectangle):void
		{
			m_Return = ImageLoader.GetImage(EmbeddedImages_HUD.HUD_Return);
			m_Return.visible = false;
			
			m_BackgroundBounds = background;
			
			m_PlayerIndex = playerIndex;
			m_PlayerNum = playerNum;
			
			positionElements();
			
			createPlayerTextField();
			createScoreTextField();
			
			this.addChild(m_PlayerTextField);
			this.addChild(m_ScoreTextField);
			this.addChild(m_Return);
		}
		
		public function Update():void
		{
			refreshScore();
		}
		
		private function refreshScore():void
		{
			m_PlayerTextField.text = "Player " + m_PlayerNum;
			m_ScoreTextField.text = "Score: " + m_Score;
		}
		
		private function positionElements():void
		{
			switch(m_PlayerIndex)
			{
				case 0:
					m_TextAlign = TextFormatAlign.LEFT;
					m_Return.x = m_BackgroundBounds.width - m_Return.FrameWidth - m_Offset_Return.x;
					m_Return.y = m_Offset_Return.y;
					break;
				case 1:
					m_TextAlign = TextFormatAlign.RIGHT;
					m_Return.x = Main.ScreenArea.x - m_BackgroundBounds.width + m_Offset_Return.x;
					m_Return.y = m_Offset_Return.y;
					break;
				case 2:
					m_TextAlign = TextFormatAlign.RIGHT;
					m_Offset.y = m_BackgroundBounds.y;
					m_Return.x = Main.ScreenArea.x - m_BackgroundBounds.width + m_Offset_Return.x;
					m_Return.y = m_Offset_Return.y + Main.ScreenArea.y - m_BackgroundBounds.height;
					break;
				case 3:
					m_TextAlign = TextFormatAlign.LEFT;
					m_Offset.y = m_BackgroundBounds.y;
					m_Return.x = m_BackgroundBounds.width - m_Return.FrameWidth - m_Offset_Return.x;
					m_Return.y = m_Offset_Return.y + Main.ScreenArea.y - m_BackgroundBounds.height;
					break;
			}
		}
		
		private function createPlayerTextField():void
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 36;
			textFormat.align = m_TextAlign;
			textFormat.color = 0xffffff;
			
			m_PlayerTextField.defaultTextFormat = textFormat;
			m_PlayerTextField.width = Main.ScreenArea.x;
			
			m_PlayerTextField.wordWrap = true;
			m_PlayerTextField.selectable = false;
			
			m_PlayerTextField.x += m_Offset.x;
			m_PlayerTextField.y += m_Offset.y;
		}
		
		private function createScoreTextField():void
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 24;
			textFormat.align = m_TextAlign;
			textFormat.color = 0xffffff;
			
			m_ScoreTextField.defaultTextFormat = textFormat;
			m_ScoreTextField.width = Main.ScreenArea.x;
			
			m_ScoreTextField.wordWrap = true;
			m_ScoreTextField.selectable = false;
			
			m_ScoreTextField.x += m_Offset.x;
			m_ScoreTextField.y += (m_Offset.y + m_TextOffset);
		}
		
		public function AdjustScore(scoreAdjustment:int):void
		{
			m_Score += scoreAdjustment;
		}
		
		public function get Score():int
		{
			return m_Score;
		}
		
		public function ToggleReturn():void
		{
			m_Return.visible = !m_Return.visible;
		}
		
		public function get ShouldReturn():Boolean
		{
			return m_Return.visible;
		}
	}
}