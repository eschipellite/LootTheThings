package Gameplay.Player 
{
	import flash.desktop.InteractiveIcon;
	import flash.display.Sprite;
	import flash.display3D.textures.RectangleTexture;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.GameInput;
	import flash.ui.GameInputControl;
	import Gameplay.EmbeddedImages_Gameplay;
	import Gameplay.Enemy.Enemy;
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
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class Player extends Sprite
	{
		protected var m_PlayerBase:PlayerBase;
		
		protected var m_Index:int;
		
		protected var m_Speed:int = 384;
		
		protected var m_ToAdjust:Point;
		protected var m_PreviousPosition:Point;
		
		protected var m_Bounds:Rectangle;
		
		protected var m_Exit:int;
		protected var m_Spawned:Boolean;
		
		protected var m_PlayerSize:Point = new Point(48, 48);
		
		protected var m_ActionState:int;
		
		public function Player() 
		{
			m_PlayerBase = new PlayerBase();
			
			m_Index = -1;
			
			m_ToAdjust = new Point(0, 0);
			m_PreviousPosition = new Point(0, 0);
			
			m_Exit = -1;
			m_Spawned = false;
			m_ActionState = ActionState.IDLE;
		}
		
		public function Initialize(index:int):void
		{
			m_Index = index;
			
			m_Bounds = new Rectangle(0, 0, Main.ScreenArea.x, Main.ScreenArea.y);
			
			loadImages();
			
			this.addChild(m_PlayerBase);
		}
		
		protected function loadImages():void
		{
			m_PlayerBase.Initialize(EmbeddedImages_Gameplay.Gameplay_Player, m_PlayerSize);
		}
		
		public function Update():void
		{
			checkMovementInput();
			checkRotationInput();
			move();
			checkAtExit();
			checkButtons();
			updateActionStates();
		}
		
		private function checkButtons():void
		{
			checkHUDToggle();
			checkReturnToggle();
			checkRightTrigger();
		}
		
		private function updateActionStates():void
		{
			switch(m_ActionState)
			{
				case ActionState.IDLE:
					break;
				case ActionState.ABILITY_ONE:
					updateAbilityOne();
					break;
			}
		}
		
		protected function updateAbilityOne():void
		{
			
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
		
		protected function checkRightTrigger():void
		{
			
		}
		
		private function checkMovementInput():void
		{
			var movement:Point = ControllerInput.GetController(m_Index).LeftStick;
			
			m_ToAdjust.x = movement.x * GameTime.ElapsedGameTimeSeconds * m_Speed;
			m_ToAdjust.y = movement.y * GameTime.ElapsedGameTimeSeconds * m_Speed;
		}
		
		protected function checkRotationInput():void
		{
			var direction:Point = ControllerInput.GetController(m_Index).RightStick;
			direction.normalize(1);
			if (direction.length != 0)
			{
				m_PlayerBase.Rotation = UtilMethods.VectorToDegreeRotation(direction);
			}
		}
		
		private function move():void
		{
			m_PreviousPosition = new Point(this.x, this.y);
			moveX();
			moveY();
			checkCollisionWithEnemies();
			
			RoomManager.CurrentTileGrid.SetPositionOccupiedFromWorld(this.Position);
		}
		
		private function checkCollisionWithEnemies():void
		{
			State_Gameplay.eventDispatcher.dispatchEvent(new PlayerCollisionEvent(PlayerCollisionEvent.CHECK_PLAYER_COLLISION_WITH_ENEMIES_EVENT, this));
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
			this.x += m_ToAdjust.x;
			checkBounds();
			checkXCollision();
			m_PreviousPosition = new Point(this.x, this.y);
		}
		
		private function moveY():void
		{
			this.y += m_ToAdjust.y;
			checkBounds();
			checkYCollision();
			m_PreviousPosition = new Point(this.x, this.y);
		}
		
		public function SetPosition(position:Point):void
		{
			this.x = position.x;
			this.y = position.y;
			
			m_PreviousPosition.x = position.x;
			m_PreviousPosition.y = position.y;
		}
		
		private function checkBounds():void
		{
			if (this.x < m_Bounds.x)
			{
				this.x = m_Bounds.x;
				m_PreviousPosition = new Point(this.x, this.y);
			}
			else if (this.x > m_Bounds.x + m_Bounds.width - m_PlayerBase.FrameWidth)
			{
				this.x = m_Bounds.x + m_Bounds.width - m_PlayerBase.FrameWidth;
				m_PreviousPosition = new Point(this.x, this.y);
			}
			
			if (this.y < m_Bounds.y)
			{
				this.y = m_Bounds.y;
				m_PreviousPosition = new Point(this.x, this.y);
			}
			else if (this.y > m_Bounds.y + m_Bounds.height - m_PlayerBase.FrameHeight)
			{
				this.y = m_Bounds.y + m_Bounds.height - m_PlayerBase.FrameHeight;
				m_PreviousPosition = new Point(this.x, this.y);
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
				this.x = Math.round(m_PreviousPosition.x * State_Gameplay.INVERT_TILE_SIZE) * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.x;
			}
			else if(secondHit)
			{
				this.x = Math.round(m_PreviousPosition.x * State_Gameplay.INVERT_TILE_SIZE) * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.x + (State_Gameplay.TILE_SIZE - m_PlayerBase.FrameWidth);
			}
				
			m_PreviousPosition.x = this.x;
		}
		
		public function SetCollisionY(firstHit:Boolean, secondHit:Boolean):void
		{
			if (firstHit)
			{
				this.y = Math.round(m_PreviousPosition.y * State_Gameplay.INVERT_TILE_SIZE) * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.y;
			}
			else if (secondHit)
			{
				this.y = Math.round(m_PreviousPosition.y * State_Gameplay.INVERT_TILE_SIZE) * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.y + (State_Gameplay.TILE_SIZE - m_PlayerBase.FrameHeight);;
			}
			
			m_PreviousPosition.y = this.y;
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
		
		public function CollisionWithEnemy(enemy:Enemy):void
		{
			var contactNormal:Point = new Point(enemy.CenterPosition.x - this.CenterPosition.x, enemy.CenterPosition.y - this.CenterPosition.y);
			var centerAbs:Point = new Point(Math.abs(contactNormal.x), Math.abs(contactNormal.y));
			var penetration:Point = new Point(centerAbs.x - (enemy.Size.x + this.Size.x) * 0.5, centerAbs.y - (enemy.Size.y + this.Size.y) * 0.5);
			contactNormal.normalize(1);
			
			var movement:Point = new Point(contactNormal.x * penetration.x, contactNormal.y * penetration.y);
			this.x += (movement.x);
			this.y += (movement.y);
			
			checkXCollision();
			checkYCollision();
		}
		
		public function get Size():Point
		{
			return new Point(m_PlayerBase.FrameWidth, m_PlayerBase.FrameHeight);
		}
		
		public function get CollisionBounds():Rectangle
		{
			return new Rectangle(this.x, this.y, m_PlayerBase.FrameWidth, m_PlayerBase.FrameHeight);
		}
		
		public function get Index():int
		{
			return m_Index;
		}
		
		public function get Position():Point
		{
			return new Point(this.x, this.y);
		}
		
		public function get CenterPosition():Point
		{
			return new Point(this.x + m_PlayerBase.FrameWidth * 0.5, this.y + m_PlayerBase.FrameHeight * 0.5);
		}
	}
}