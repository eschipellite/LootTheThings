package Gameplay.Player 
{
	import flash.desktop.InteractiveIcon;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.GameInput;
	import flash.ui.GameInputControl;
	import Gameplay.HUD.Events.HUDEvent;
	import Gameplay.Level.Events.PlayerCollisionEvent;
	import Gameplay.Level.RoomManager;
	import Gameplay.State_Gameplay;
	import General.Camera;
	import Utils.GameTime;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	import Utils.InputContent.Controllers.ControllerInput;
	import Utils.InputContent.Controllers.GameController;
	import Utils.Output.Console;
	/**
	 * ...
	 * @author ...
	 */
	public class Player extends Sprite
	{
		private var m_Image_Player:Image;
		
		private var m_Index:int;
		
		private var m_Speed:int = 384;
		
		private var m_ToAdjust:Point;
		private var m_PreviousPosition:Point;
		
		private var m_Bounds:Rectangle;
		
		private var m_Exit:int;
		private var m_Spawned:Boolean;
		
		public function Player() 
		{
			m_Index = -1;
			
			m_ToAdjust = new Point(0, 0);
			m_PreviousPosition = new Point(0, 0);
			
			m_Exit = -1;
			m_Spawned = false;
		}
		
		public function Initialize(index:int):void
		{
			m_Index = index;
			
			m_Bounds = new Rectangle(0, 0, Main.ScreenArea.x, Main.ScreenArea.y);
			
			m_Image_Player = ImageLoader.GetImage(EmbeddedImages_Player.Player_Player);
			m_Image_Player.Frame = m_Index;
			
			this.addChild(m_Image_Player);
		}
		
		public function Update():void
		{
			checkInput();
			move();
			checkAtExit();
			checkButtons();
		}
		
		private function checkButtons():void
		{
			checkHUDToggle();
			checkReturnToggle();
		}
		
		private function checkHUDToggle():void
		{
			if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.BUTTON_C))
			{
				State_Gameplay.eventDispatcher.dispatchEvent(new HUDEvent(HUDEvent.TOGGLE_HUD_EVENT, m_Index));
			}
		}
		
		private function checkReturnToggle():void
		{
			if (ControllerInput.GetController(m_Index).ButtonPressed(GameController.BUTTON_D))
			{
				State_Gameplay.eventDispatcher.dispatchEvent(new HUDEvent(HUDEvent.TOGGLE_RETURN_EVENT, m_Index));
			}
		}
		
		private function checkInput():void
		{
			var movement:Point = ControllerInput.GetController(m_Index).LeftStick;
			
			m_ToAdjust.x = movement.x * GameTime.ElapsedGameTimeSeconds * m_Speed;
			m_ToAdjust.y = movement.y * GameTime.ElapsedGameTimeSeconds * m_Speed;
		}
		
		private function move():void
		{
			moveX();
			moveY();
		}
		
		private function checkAtExit():void
		{
			State_Gameplay.eventDispatcher.dispatchEvent(new PlayerCollisionEvent(PlayerCollisionEvent.CHECK_PLAYER_AT_EXIT_EVENT, this));
		}
		
		public function SetAtExit(exit:int):void
		{
			m_Exit = exit;
		}
		
		public function get Exit():int
		{
			return m_Exit;
		}
		
		public function set Spawned(spawned:Boolean):void
		{
			m_Spawned = spawned;
		}
		
		public function get Spawned():Boolean
		{
			return m_Spawned;
		}
		
		private function moveX():void
		{
			m_Image_Player.x += m_ToAdjust.x;
			checkBounds();
			checkXCollision();
			m_PreviousPosition = new Point(m_Image_Player.x, m_Image_Player.y);
		}
		
		private function moveY():void
		{
			m_Image_Player.y += m_ToAdjust.y;
			checkBounds();
			checkYCollision();
			m_PreviousPosition = new Point(m_Image_Player.x, m_Image_Player.y);
		}
		
		public function SetPosition(position:Point):void
		{
			m_Image_Player.x = position.x;
			m_Image_Player.y = position.y;
			
			m_PreviousPosition.x = position.x;
			m_PreviousPosition.y = position.y;
		}
		
		private function checkBounds():void
		{
			if (m_Image_Player.x < m_Bounds.x)
			{
				m_Image_Player.x = m_Bounds.x;
				m_PreviousPosition = new Point(m_Image_Player.x, m_Image_Player.y);
			}
			else if (m_Image_Player.x > m_Bounds.x + m_Bounds.width - m_Image_Player.FrameWidth)
			{
				m_Image_Player.x = m_Bounds.x + m_Bounds.width - m_Image_Player.FrameWidth;
				m_PreviousPosition = new Point(m_Image_Player.x, m_Image_Player.y);
			}
			
			if (m_Image_Player.y < m_Bounds.y)
			{
				m_Image_Player.y = m_Bounds.y;
				m_PreviousPosition = new Point(m_Image_Player.x, m_Image_Player.y);
			}
			else if (m_Image_Player.y > m_Bounds.y + m_Bounds.height - m_Image_Player.FrameHeight)
			{
				m_Image_Player.y = m_Bounds.y + m_Bounds.height - m_Image_Player.FrameHeight;
				m_PreviousPosition = new Point(m_Image_Player.x, m_Image_Player.y);
			}
		}
		
		private function checkXCollision():void
		{
			State_Gameplay.eventDispatcher.dispatchEvent(new PlayerCollisionEvent(PlayerCollisionEvent.CHECK_PLAYER_X_COLLISION_EVENT, this));
		}
		
		public function SetCollisionX(firstHit:Boolean, secondHit:Boolean):void
		{
			if (firstHit)
			{
				m_Image_Player.x = Math.round(m_PreviousPosition.x * State_Gameplay.INVERT_TILE_SIZE) * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.x;
			}
			else if(secondHit)
			{
				m_Image_Player.x = Math.round(m_PreviousPosition.x * State_Gameplay.INVERT_TILE_SIZE) * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.x + (State_Gameplay.TILE_SIZE - m_Image_Player.FrameWidth);
			}
				
			m_PreviousPosition.x = m_Image_Player.x;
		}
		
		public function SetCollisionY(firstHit:Boolean, secondHit:Boolean):void
		{
			if (firstHit)
			{
				m_Image_Player.y = Math.round(m_PreviousPosition.y * State_Gameplay.INVERT_TILE_SIZE) * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.y;
			}
			else if (secondHit)
			{
				m_Image_Player.y = Math.round(m_PreviousPosition.y * State_Gameplay.INVERT_TILE_SIZE) * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.y + (State_Gameplay.TILE_SIZE - m_Image_Player.FrameHeight);;
			}
			
			m_PreviousPosition.y = m_Image_Player.y;
		}
		
		private function checkYCollision():void
		{
			State_Gameplay.eventDispatcher.dispatchEvent(new PlayerCollisionEvent(PlayerCollisionEvent.CHECK_PLAYER_Y_COLLISION_EVENT, this));
		}
		
		public function SetBoundsPosition(position:Point):void
		{
			m_Bounds.x = position.x;
			m_Bounds.y = position.y;
		}
		
		public function get Size():Point
		{
			return new Point(m_Image_Player.FrameWidth, m_Image_Player.FrameHeight);
		}
		
		public function get CollisionBounds():Rectangle
		{
			return m_Image_Player.CollisionBounds;
		}
		
		public function get Index():int
		{
			return m_Index;
		}
	}
}