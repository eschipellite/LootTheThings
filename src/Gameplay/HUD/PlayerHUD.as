package Gameplay.HUD 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import Gameplay.EmbeddedImages_Gameplay;
	import Gameplay.HUD.Map.HUDMap;
	import Gameplay.HUD.PlayerInfo.PlayerInfo;
	import Gameplay.Level.RoomInfo;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerHUD extends Sprite
	{	
		private var m_HudBackground:Image;
		
		private var m_PlayerIndex:int;
		private var m_PlayerNum:int;
		
		private var m_Offset_HUDMap:Point = new Point(32, 32);
		
		private var m_HUDState:int;
		
		private var m_HUDMap:HUDMap;
		private var m_PlayerInfo:PlayerInfo;
		
		public function PlayerHUD() 
		{
			m_PlayerIndex = -1;
			m_PlayerNum = -1;
			
			m_HUDMap = new HUDMap();
			m_PlayerInfo = new PlayerInfo();
		}
		
		public function Initialize(playerIndex:int):void
		{
			m_HudBackground = ImageLoader.GetImage(EmbeddedImages_HUD.HUD_Background);
			
			m_PlayerIndex = playerIndex;
			m_PlayerNum = m_PlayerIndex + 1;
			
			positionElements();
			
			m_HUDMap.Initialize();
			m_PlayerInfo.Initialize(m_PlayerIndex, m_PlayerNum, m_HudBackground.CollisionBounds);
			
			this.addChild(m_HudBackground);
			
			m_HUDState =  HUDStates.PLAYER_INFO;
			setHUDState();
		}
		
		private function positionElements():void
		{
			m_HudBackground.Frame = m_PlayerIndex;
			
			switch(m_PlayerIndex)
			{
				case 0:
					m_HudBackground.x = 0;
					m_HudBackground.y = 0;
					m_HUDMap.x = 0;
					m_HUDMap.y = 0;
					break;
				case 1:
					m_HudBackground.x = Main.ScreenArea.x - m_HudBackground.FrameWidth;
					m_HudBackground.y = 0;
					m_HUDMap.x = Main.ScreenArea.x - m_HudBackground.FrameWidth;
					m_HUDMap.y = 0;
					break;
				case 2:
					m_HudBackground.x = Main.ScreenArea.x - m_HudBackground.FrameWidth;
					m_HudBackground.y = Main.ScreenArea.y - m_HudBackground.FrameHeight;
					m_HUDMap.x = Main.ScreenArea.x - m_HudBackground.FrameWidth;
					m_HUDMap.y = Main.ScreenArea.y - m_HudBackground.FrameHeight;
					break;
				case 3:
					m_HudBackground.x = 0;
					m_HudBackground.y = Main.ScreenArea.y - m_HudBackground.FrameHeight;
					m_HUDMap.x = 0;
					m_HUDMap.y = Main.ScreenArea.y - m_HudBackground.FrameHeight;
					break;
			}
			
			m_HUDMap.x += m_Offset_HUDMap.x;
			m_HUDMap.y += m_Offset_HUDMap.y;
		}
		
		public function Update():void
		{
			m_PlayerInfo.Update();
		}
		
		public function ToggleHUD():void
		{
			switch(m_HUDState)
			{
				case HUDStates.PLAYER_INFO:
					m_HUDState = HUDStates.MINI_MAP;
					break;
				case HUDStates.MINI_MAP:
					m_HUDState = HUDStates.PLAYER_INFO;
					break;
			}
			
			setHUDState();
		}
		
		public function ToggleReturn():void
		{
			m_PlayerInfo.ToggleReturn();
		}
		
		private function setHUDState():void
		{
			if (this.contains(m_PlayerInfo))
			{
				this.removeChild(m_PlayerInfo);
			}
			
			if (this.contains(m_HUDMap))
			{
				this.removeChild(m_HUDMap);
			}
			
			switch(m_HUDState)
			{
				case HUDStates.PLAYER_INFO:
					this.addChild(m_PlayerInfo);
					break;
				case HUDStates.MINI_MAP:
					this.addChild(m_HUDMap);
					break;
			}
		}
		
		public function SetRoomInformation(roomInformation:Vector.<RoomInfo>):void
		{
			m_HUDMap.SetRoomInformation(roomInformation);
		}
		
		public function SetRoomInfo(roomInfo:RoomInfo):void
		{
			m_HUDMap.SetRoomInfo(roomInfo);
		}
		
		public function ChangeRoom(direction:int):void
		{
			m_HUDMap.ChangeRoom(direction);
		}
		
		public function AdjustScore(scoreAdjustment:int):void
		{
			m_PlayerInfo.AdjustScore(scoreAdjustment);
		}
		
		public function get Index():int
		{
			return m_PlayerIndex;
		}
		
		public function get Score():int
		{
			return m_PlayerInfo.Score;
		}
		
		public function get PlayerNum():int
		{
			return m_PlayerNum;
		}
		
		public function get ShouldReturn():Boolean
		{
			return m_PlayerInfo.ShouldReturn;
		}
	}
}