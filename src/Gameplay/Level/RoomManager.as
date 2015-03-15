package Gameplay.Level 
{
	import flash.desktop.InteractiveIcon;
	import flash.display.Sprite;
	import flash.events.NativeWindowBoundsEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Gameplay.HUD.Events.RoomInfoEvent;
	import Gameplay.Level.Events.PlayerCollisionEvent;
	import Gameplay.Level.Events.RoomEvent;
	import Gameplay.Player.Events.SpawnPlayersEvent;
	import Gameplay.State_Gameplay;
	import General.Camera;
	import General.Embedded_Content.EmbeddedFiles_General;
	import Menu.PlayerSelection.Events.LevelSelectorEvent;
	import Menu.PlayerSelection.State_PlayerSelection;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class RoomManager extends Sprite
	{	
		public static const ROOM_OFFSET:Point = new Point(0, 8);
		
		private var m_RoomTypes:Vector.<String>;
		private var m_Rooms:Vector.<Room>;
		
		private var m_StartRoomType:String;
		private var m_StartRoomBounds:Rectangle;
		
		private var m_Divergence:int = 15;
		private var m_CurrentDivergence:int;
		private var m_TotalRooms:int = 50;
		
		private var m_CurrentRoom:Room;
		
		public function RoomManager() 
		{
			m_RoomTypes = new Vector.<String>();
			m_Rooms = new Vector.<Room>();
		}	
		
		public function Initialize():void
		{
			initializeRoomTypes();
		}
		
		private function initializeRoomTypes():void
		{
			var xml:XML = new XML(new EmbeddedFiles_General.General_Rooms);
			
			m_StartRoomType = xml.startroom.grid;
			m_StartRoomBounds = UtilMethods.StringToRectangle(xml.startroom.bounds);
			
			var rooms:XMLList = xml.room;
			
			for (var index:int = 0; index < rooms.length(); index++)
			{
				var roomType:String = rooms[index].grid;
				m_RoomTypes.push(roomType);
			}
		}
		
		public function InitializeEventListeners():void
		{
			State_Gameplay.eventDispatcher.addEventListener(PlayerCollisionEvent.CHECK_PLAYER_X_COLLISION_EVENT, eh_CheckPlayerXCollision);
			State_Gameplay.eventDispatcher.addEventListener(PlayerCollisionEvent.CHECK_PLAYER_Y_COLLISION_EVENT, eh_CheckPlayerYCollision);
			State_Gameplay.eventDispatcher.addEventListener(PlayerCollisionEvent.CHECK_PLAYER_AT_EXIT_EVENT, eh_CheckPlayerAtExit);
			State_Gameplay.eventDispatcher.addEventListener(RoomEvent.CHANGE_ROOM_EVENT, eh_ChangeRoomEvent);
			State_PlayerSelection.eventDispatcher.addEventListener(LevelSelectorEvent.SET_LEVEL_INFORMATION_EVENT, eh_SetLevelInformation);
		}
		
		private function eh_SetLevelInformation(evt:LevelSelectorEvent):void
		{
			m_TotalRooms = evt.E_NumRooms;
			m_Divergence = evt.E_Divergence;
		}
		
		public function Begin():void
		{
			reset();
			
			createRooms();
			initializeRooms();
			
			setCurrentRoom(0);
			
			sendRoomInformation();
		}
		
		private function sendRoomInformation():void
		{
			var roomInformation:Vector.<RoomInfo> = GetRoomInformation();
			
			State_Gameplay.eventDispatcher.dispatchEvent(new RoomInfoEvent(RoomInfoEvent.SEND_ALL_ROOM_INFORMATION_EVENT, roomInformation));
		}
		
		public function Leave():void
		{
			reset();
		}
		
		public function Update():void
		{
			
		}
		
		private function eh_ChangeRoomEvent(evt:RoomEvent):void
		{
			m_CurrentRoom.SetRoomState(RoomStates.VISITED);
			State_Gameplay.eventDispatcher.dispatchEvent(new RoomInfoEvent(RoomInfoEvent.SEND_ROOM_INFO_EVENT, null, m_CurrentRoom.GetRoomInformation()));
			
			var changeRoom:Room = m_CurrentRoom.GetConnection(evt.E_Exit);
			m_CurrentRoom = changeRoom;
			m_CurrentRoom.SetRoomState(RoomStates.CURRENT);
			Camera.SetPosition(m_CurrentRoom.Position);
			
			var spawn:int = Direction.GetOppositeExit(evt.E_Exit);
			var spawnPoints:Vector.<Rectangle> = m_CurrentRoom.GetSpawnBlocks(spawn);
			State_Gameplay.eventDispatcher.dispatchEvent(new SpawnPlayersEvent(SpawnPlayersEvent.SPAWN_PLAYERS_EVENT, spawnPoints, m_CurrentRoom.Position));
			State_Gameplay.eventDispatcher.dispatchEvent(new RoomInfoEvent(RoomInfoEvent.SEND_ROOM_INFO_EVENT, null, m_CurrentRoom.GetRoomInformation()));
		}
		
		private function eh_CheckPlayerXCollision(evt:PlayerCollisionEvent):void
		{
			var playerRectangle:Rectangle = evt.E_Player.CollisionBounds;
			playerRectangle.x -= m_CurrentRoom.Position.x;
			playerRectangle.y -= m_CurrentRoom.Position.y;
			
			playerRectangle.y += 1;
			playerRectangle.height -= 2;
			
			var hitList:Vector.<Boolean> = new Vector.<Boolean>();
			hitList = checkCollision(createXPointArray(playerRectangle));
			evt.E_Player.SetCollisionX(hitList[0], hitList[1]);
		}
		
		private function eh_CheckPlayerYCollision(evt:PlayerCollisionEvent):void
		{
			var playerRectangle:Rectangle = evt.E_Player.CollisionBounds;
			playerRectangle.x -= m_CurrentRoom.Position.x;
			playerRectangle.y -= m_CurrentRoom.Position.y;
			
			playerRectangle.x += 1;
			playerRectangle.width -= 2;
			
			var hitList:Vector.<Boolean> = new Vector.<Boolean>();
			hitList = checkCollision(createYPointArray(playerRectangle));
			evt.E_Player.SetCollisionY(hitList[0], hitList[1]);
		}
		
		private function createXPointArray(rectangle:Rectangle):Array
		{
			var pointArray:Array = new Array;
			
			var x:int = (rectangle.x - RoomManager.ROOM_OFFSET.x) * State_Gameplay.INVERT_TILE_SIZE;
			var y:int = (rectangle.y - RoomManager.ROOM_OFFSET.y) * State_Gameplay.INVERT_TILE_SIZE;
			var xWidth:int = int(rectangle.x - RoomManager.ROOM_OFFSET.x + rectangle.width) * State_Gameplay.INVERT_TILE_SIZE;
			var yHeight:int = int(rectangle.y - RoomManager.ROOM_OFFSET.y + rectangle.height) * State_Gameplay.INVERT_TILE_SIZE;
			
			pointArray.push(new Point(x, y));
			pointArray.push(new Point(x, yHeight));
			pointArray.push(new Point(xWidth, y));
			pointArray.push(new Point(xWidth, yHeight));
			
			return pointArray;
		}
		
		private function createYPointArray(rectangle:Rectangle):Array
		{
			var pointArray:Array = new Array;
			
			var x:int = (rectangle.x - RoomManager.ROOM_OFFSET.x) * State_Gameplay.INVERT_TILE_SIZE;
			var y:int = (rectangle.y - RoomManager.ROOM_OFFSET.y) * State_Gameplay.INVERT_TILE_SIZE;
			var xWidth:int = int(rectangle.x - RoomManager.ROOM_OFFSET.x + rectangle.width) * State_Gameplay.INVERT_TILE_SIZE;
			var yHeight:int = int(rectangle.y - RoomManager.ROOM_OFFSET.y + rectangle.height) * State_Gameplay.INVERT_TILE_SIZE;
			
			pointArray.push(new Point(x, y));
			pointArray.push(new Point(xWidth, y));
			pointArray.push(new Point(xWidth, yHeight));
			pointArray.push(new Point(x, yHeight));
			
			return pointArray;
		}
		
		private function checkCollision(pointArray:Array):Vector.<Boolean>
		{	
			var firstHit:Boolean = true;
			var secondHit:Boolean = true;
			
			var tileMap:Array = m_CurrentRoom.TileMap;
			
			firstHit = tileMap[pointArray[0].y][pointArray[0].x] == TileValues.WALL || tileMap[pointArray[1].y][pointArray[1].x] == TileValues.WALL;
			secondHit = tileMap[pointArray[2].y][pointArray[2].x] == TileValues.WALL || tileMap[pointArray[3].y][pointArray[3].x] == TileValues.WALL;
			
			var hitList:Vector.<Boolean> = new Vector.<Boolean>();
			hitList.push(firstHit);
			hitList.push(secondHit);
			return hitList;
		}
		
		private function eh_CheckPlayerAtExit(evt:PlayerCollisionEvent):void
		{
			var playerRectangle:Rectangle = evt.E_Player.CollisionBounds;
			
			var exit:int = m_CurrentRoom.CheckAtExit(playerRectangle);
			
			evt.E_Player.SetAtExit(exit);
			
			if (evt.E_Player.Exit == -1)
			{
				evt.E_Player.Spawned = false;
			}
		}
		
		private function setCurrentRoom(roomIndex:int):void
		{
			for each(var room:Room in m_Rooms)
			{
				if (room.RoomIndex == roomIndex)
				{
					m_CurrentRoom = room;
					m_CurrentRoom.SetRoomState(RoomStates.CURRENT);
				}
			}
		}
		
		private function reset():void
		{
			for each(var room:Room in m_Rooms)
			{
				if (this.contains(room))
				{
					this.removeChild(room);
				}
			}
			
			m_Rooms = new Vector.<Room>();
		}
		
		private function createRooms():void
		{
			var currentRoomIndex:int = 0;
			
			m_CurrentDivergence = m_Divergence;
			
			var firstRoom:Room = new Room();
			firstRoom.SetRoomType(m_StartRoomType);
			firstRoom.SetRoomIndex(currentRoomIndex);
			m_Rooms.push(firstRoom);
			
			currentRoomIndex++;
			
			for (var index:int = 0; index < m_TotalRooms - 1; index++)
			{	
				var roomCreated:Boolean = false;
				
				while (!roomCreated)
				{
					var tempRooms:Vector.<Room> = m_Rooms;
					UtilMethods.ShuffleVector(tempRooms);
					for each(var tempRoom:Room in tempRooms)
					{
						if (tempRoom.Divergence < m_CurrentDivergence && tempRoom.HasAvailableConnection)
						{
							var newRoom:Room = tempRoom.CreateNewRoom();
							newRoom.SetRoomIndex(currentRoomIndex);
							updateConnections(newRoom);
							
							m_Rooms.push(newRoom);
							
							roomCreated = true;
							currentRoomIndex++;
							
							break;
						}
					}
					
					if (!roomCreated)
					{
						m_CurrentDivergence++;
					}
				}
			}
		}
		
		private function updateConnections(newRoom:Room):void
		{
			for each(var room:Room in m_Rooms)
			{
				room.CheckForAdjacency(newRoom);
			}
		}
		
		private function initializeRooms():void
		{
			for each(var room:Room in m_Rooms)
			{
				if (!room.HasRoomType)
				{
					var randomRoomType:String = getRandomRoomType();
					room.SetRoomType(randomRoomType);
				}
				
				room.Initialize();
				
				room.x = room.GridPosition.x * room.Size.x;
				room.y = room.GridPosition.y * room.Size.y;
				
				this.addChild(room);
			}
		}
		
		private function getRandomRoomType():String
		{
			var randomIndex:int = UtilMethods.Random(0, m_RoomTypes.length - 1, UtilMethods.ROUND);
			return m_RoomTypes[randomIndex];
		}
		
		public function get StartBounds():Rectangle
		{
			return m_StartRoomBounds;
		}
		
		public function GetRoomInformation():Vector.<RoomInfo>
		{
			var roomInformation:Vector.<RoomInfo> = new Vector.<RoomInfo>();
			
			for each(var room:Room in m_Rooms)
			{
				roomInformation.push(room.GetRoomInformation());
			}
			
			return roomInformation;
		}
	}
}