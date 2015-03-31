package Gameplay.Enemy 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Gameplay.EmbeddedImages_Gameplay;
	import Gameplay.Level.Events.PlayerCollisionEvent;
	import Gameplay.Level.RoomManager;
	import Gameplay.Player.Player;
	import Gameplay.State_Gameplay;
	import Utils.GameTime;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	import Utils.Pathfinding.Node;
	import Utils.Pathfinding.Path;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class Enemy extends Sprite
	{
		private var m_Image:Image;
		
		private var m_RoomGridPosition:Point;
		private var m_RoomSize:Point;
		
		private var m_Path:Path;
		private var m_CurrentNode:int;
		private var m_CurrentNodePosition:Point;
		
		private var m_Speed:Point = new Point(96, 96);
		
		private var m_State:int;
		
		private var m_TimeToPath:Number = 2;
		private var m_CurrentTimeToPath:Number;
		
		public function Enemy() 
		{
			m_RoomGridPosition = new Point(0, 0);
			m_RoomSize = new Point(0, 0);
			m_CurrentNodePosition = new Point(0, 0);
			m_CurrentTimeToPath = 0;
		}	
		
		public function Initialize(gridPosition:Point, roomSize:Point):void
		{
			m_Image = ImageLoader.GetImage(EmbeddedImages_Gameplay.Gameplay_Enemy);
			
			m_RoomGridPosition = gridPosition;
			m_RoomSize = roomSize;
			
			this.addChild(m_Image);
		}
		
		public function Update():void
		{
			switch(m_State)
			{
				case EnemyStates.IDLE:
					idle();
					break;
				case EnemyStates.RANDOM_PATHING:
					move();
					break;
			}
		}
		
		private function idle():void
		{
			startRandomPathing();
		}
		
		private function startRandomPathing():void
		{
			m_State = EnemyStates.RANDOM_PATHING;
			
			findPath(RoomManager.CurrentTileGrid.GetRandomAvailablePosition());
		}
		
		private function findPath(moveToPosition:Point):void
		{
			m_Path = RoomManager.CurrentTileGrid.FindPath(this.Position, moveToPosition);
			
			m_CurrentTimeToPath = 0;
			if (m_Path.GetNodes().length > 1)
			{
				m_CurrentNode = 1;
				m_CurrentNodePosition = m_Path.GetNodes()[m_CurrentNode].Position;
				m_CurrentTimeToPath = 0;
			}
			else
			{
				m_State = EnemyStates.IDLE;
			}
		}
		
		private function move():void
		{
			var direction:Point = new Point(0, 0);
			direction.x = m_CurrentNodePosition.x - this.x;
			direction.y = m_CurrentNodePosition.y - this.y;
			direction.normalize(1);
			
			var nextPosition:Point = new Point(this.x, this.y);
			nextPosition.x += direction.x * m_Speed.x * GameTime.ElapsedGameTimeSeconds;
			nextPosition.y += direction.y * m_Speed.y * GameTime.ElapsedGameTimeSeconds;
			
			if (((direction.x > 0 && nextPosition.x >= m_CurrentNodePosition.x) || (direction.x < 0 && nextPosition.x <= m_CurrentNodePosition.x) || (direction.x == 0)) &&
				((direction.y > 0 && nextPosition.y >= m_CurrentNodePosition.y) || (direction.y < 0 && nextPosition.y <= m_CurrentNodePosition.y) || (direction.y == 0)))
			{
				this.x = m_CurrentNodePosition.x;
				this.y = m_CurrentNodePosition.y;
				
				followPath();
			}
			else
			{
				m_Image.Rotation = UtilMethods.VectorToDegreeRotation(direction);
				this.x += direction.x * m_Speed.x * GameTime.ElapsedGameTimeSeconds;
				this.y += direction.y * m_Speed.y * GameTime.ElapsedGameTimeSeconds;
			}
			
			m_CurrentTimeToPath += GameTime.ElapsedGameTimeSeconds;
			
			if (m_CurrentTimeToPath >= m_TimeToPath)
			{
				findPath(m_CurrentNodePosition);
			}
		}
		
		private function followPath():void
		{
			if (m_Path.NumNodes <= 1)
			{
				m_Path.Clear();
				
				m_State = EnemyStates.IDLE;
			}
			else
			{
				m_CurrentNodePosition = m_Path.GetNodes()[m_CurrentNode].Position;
				
					m_CurrentNode++;
					
					if (m_CurrentNode >= m_Path.NumNodes)
					{
						m_Path.Clear();
						m_CurrentNode = 1;
						
						m_State = EnemyStates.IDLE;
					}
			}
		}
		
		public function CheckPlayerCollision(player:Player):void
		{
			if (player.CollisionBounds.intersects(this.CollisionBounds))
			{
				player.CollisionWithEnemy(this);
				findPath(m_CurrentNodePosition);
			}
		}
		
		public function get Position():Point
		{
			return new Point(this.x, this.y);
		}
		
		public function get CenterPosition():Point
		{
			return new Point(this.x + m_Image.FrameWidth * 0.5, this.y + m_Image.FrameHeight * 0.5);
		}
		
		public function get CollisionBounds():Rectangle
		{
			return new Rectangle(this.x, this.y, m_Image.FrameWidth, m_Image.FrameHeight);
		}
		
		public function get Size():Point
		{
			return new Point(m_Image.FrameWidth, m_Image.FrameHeight);
		}
	}
}