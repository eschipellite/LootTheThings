package Gameplay.Level 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Gameplay.EmbeddedImages_Gameplay;
	import Gameplay.State_Gameplay;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class Room extends Sprite
	{
		private var m_NorthExit:int;
		private var m_SouthExit:int;
		private var m_EastExit:int;
		private var m_WestExit:int;
		
		private var m_RoomArray:Array;
		private var m_RoomSize:Point;
		
		private var m_TileMap:Image;
		
		private var m_Divergence:int;
		
		private var m_GridPosition:Point;
		
		private var m_NorthRoom:Room;
		private var m_SouthRoom:Room;
		private var m_EastRoom:Room;
		private var m_WestRoom:Room;
		
		private var m_RoomType:String;
		
		private var m_RoomIndex:int;
		
		private var m_NorthSpawnBlocks:Vector.<Rectangle>;
		private var m_SouthSpawnBlocks:Vector.<Rectangle>;
		private var m_EastSpawnBlocks:Vector.<Rectangle>;
		private var m_WestSpawnBlocks:Vector.<Rectangle>;
		
		private var m_RoomState:int;
		
		private var m_NumEnemies:int = 50;
		
		public function Room() 
		{	
			m_NorthExit = ExitStates.CLOSED_AVAILABLE;
			m_SouthExit = ExitStates.CLOSED_AVAILABLE;
			m_EastExit = ExitStates.CLOSED_AVAILABLE;
			m_WestExit = ExitStates.CLOSED_AVAILABLE;
			
			m_RoomSize = new Point(0, 0);
			
			m_Divergence = 0;
			m_GridPosition = new Point(0, 0);
			
			m_RoomType = "";
			
			m_RoomIndex = -1;
			
			m_NorthSpawnBlocks = new Vector.<Rectangle>();
			m_SouthSpawnBlocks = new Vector.<Rectangle>();
			m_EastSpawnBlocks = new Vector.<Rectangle>();
			m_WestSpawnBlocks = new Vector.<Rectangle>();
		}
		
		public function Initialize():void
		{
			m_RoomArray = UtilMethods.StringTo2DArray(m_RoomType);
			m_RoomSize = new Point(m_RoomArray[0].length, m_RoomArray.length);
			
			m_RoomState = RoomStates.NOT_VISITED;
			
			createExits();
			createTiles();
			createSpawnPoints();
			setBottomPerimeter();
		}
		
		public function SetRoomType(roomType:String):void
		{
			m_RoomType = roomType;
		}
		
		public function SetRoomIndex(roomIndex:int):void
		{
			m_RoomIndex = roomIndex;
		}
		
		public function get HasRoomType():Boolean
		{
			return m_RoomType != "";
		}
		
		private function createExits():void
		{			
			if (m_NorthExit != ExitStates.CLOSED_AVAILABLE)
			{
				createNorthExit();
			}
			
			if (m_SouthExit != ExitStates.CLOSED_AVAILABLE)
			{
				createSouthExit();
			}
			
			if (m_EastExit != ExitStates.CLOSED_AVAILABLE)
			{
				createEastExit();
			}
			
			if (m_WestExit != ExitStates.CLOSED_AVAILABLE)
			{
				createWestExit();
			}
		}
		
		private function createSpawnPoints():void
		{
			createNorthSpawnBlocks();
			createSouthSpawnBlocks();
			createEastSpawnBlocks();
			createWestSpawnBlocks();
		}
		
		private function createNorthSpawnBlocks():void
		{
			for (var col:int = 0; col < m_RoomArray[0].length; col++)
			{
				if (m_RoomArray[0][col] == TileValues.OPEN)
				{
					var spawnPoint:Point = new Point(col, 0);
					spawnPoint.x = spawnPoint.x * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.x + Position.x;
					spawnPoint.y = spawnPoint.y * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.y + Position.y;
					m_NorthSpawnBlocks.push(new Rectangle(spawnPoint.x, spawnPoint.y, State_Gameplay.TILE_SIZE, State_Gameplay.TILE_SIZE));
				}
			}
		}
		
		private function createSouthSpawnBlocks():void
		{
			for (var col:int = 0; col < m_RoomArray[m_RoomSize.y - 1].length; col++)
			{
				if (m_RoomArray[m_RoomSize.y - 1][col] == TileValues.OPEN)
				{
					var spawnPoint:Point = new Point(col, m_RoomSize.y - 1);
					spawnPoint.x = spawnPoint.x * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.x + Position.x;
					spawnPoint.y = spawnPoint.y * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.y + Position.y;
					m_SouthSpawnBlocks.push(new Rectangle(spawnPoint.x, spawnPoint.y, State_Gameplay.TILE_SIZE, State_Gameplay.TILE_SIZE));
				}
			}
		}
		
		private function createEastSpawnBlocks():void
		{
			for (var row:int = 0; row < m_RoomArray.length; row++)
			{
				if (m_RoomArray[row][m_RoomSize.x - 1] == TileValues.OPEN)
				{
					var spawnPoint:Point = new Point(m_RoomSize.x - 1, row);
					spawnPoint.x = spawnPoint.x * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.x + Position.x;
					spawnPoint.y = spawnPoint.y * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.y + Position.y;
					m_EastSpawnBlocks.push(new Rectangle(spawnPoint.x, spawnPoint.y, State_Gameplay.TILE_SIZE, State_Gameplay.TILE_SIZE));
				}
			}
		}
		
		private function createWestSpawnBlocks():void
		{
			for (var row:int = 0; row < m_RoomArray.length; row++)
			{
				if (m_RoomArray[row][0] == TileValues.OPEN)
				{
					var spawnPoint:Point = new Point(0, row);
					spawnPoint.x = spawnPoint.x * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.x + Position.x;
					spawnPoint.y = spawnPoint.y * State_Gameplay.TILE_SIZE + RoomManager.ROOM_OFFSET.y + Position.y;
					m_WestSpawnBlocks.push(new Rectangle(spawnPoint.x, spawnPoint.y, State_Gameplay.TILE_SIZE, State_Gameplay.TILE_SIZE));
				}
			}
		}
		
		private function setBottomPerimeter():void
		{
			m_RoomArray[m_RoomSize.y] = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1 ];
		}
		
		private function createNorthExit():void
		{
			m_RoomArray[0] = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1 ];
		}
		
		private function createSouthExit():void
		{
			m_RoomArray[m_RoomSize.y - 1] = [1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1 ];
		}
		
		private function createEastExit():void
		{
			var tempArray:Array = [1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1];
			
			for (var row:int = 0; row < m_RoomArray.length; row++)
			{
				m_RoomArray[row][m_RoomSize.x - 1] = tempArray[row];
			}
		}
		
		private function createWestExit():void
		{
			var tempArray:Array = [1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1];
			
			for (var row:int = 0; row < m_RoomArray.length; row++)
			{
				m_RoomArray[row][0] = tempArray[row];
			}
		}
		
		private function createTiles():void
		{
			var tileBitmapData:BitmapData = new BitmapData(Size.x, Size.y);
			
			for (var row:int = 0; row < m_RoomArray.length; row++)
			{
				for (var col:int = 0; col < m_RoomArray[row].length; col++)
				{
					var tileImage:Image = loadTileMapImage(m_RoomArray[row][col]);
					
					tileImage.x = col * State_Gameplay.TILE_SIZE;
					tileImage.y = row * State_Gameplay.TILE_SIZE;
					
					tileBitmapData.copyPixels(tileImage.bitmapData, tileImage.scrollRect, new Point(tileImage.x, tileImage.y));
				}
			}
			
			m_TileMap = new Image(tileBitmapData);
			m_TileMap.x = RoomManager.ROOM_OFFSET.x;
			m_TileMap.y = RoomManager.ROOM_OFFSET.y;
			
			this.addChild(m_TileMap);
		}
		
		private function loadTileMapImage(tileMapIndex:int):Image
		{
			var tileImage:Image = ImageLoader.GetImage(EmbeddedImages_Gameplay.Gameplay_Tiles);
			tileImage.Frame = tileMapIndex;
			
			return tileImage;
		}
		
		public function CreateNewRoom():Room
		{
			var room:Room = new Room();
			room.GridPosition = new Point(m_GridPosition.x, m_GridPosition.y);
			
			var directions:Vector.<int> = new Vector.<int>();
			
			if (m_NorthExit == ExitStates.CLOSED_AVAILABLE)
			{
				directions.push(Direction.NORTH);
			}
			
			if (m_SouthExit == ExitStates.CLOSED_AVAILABLE)
			{
				directions.push(Direction.SOUTH);
			}
			
			if (m_EastExit == ExitStates.CLOSED_AVAILABLE)
			{
				directions.push(Direction.EAST);
			}
			
			if (m_WestExit == ExitStates.CLOSED_AVAILABLE)
			{
				directions.push(Direction.WEST);
			}
			
			var randomIndex:int = UtilMethods.Random(0, directions.length - 1, UtilMethods.ROUND);
			var direction:int = directions[randomIndex];
			
			switch(direction)
			{
				case Direction.NORTH:
					m_NorthExit = ExitStates.OPEN_CONNECTED;
					room.SouthExit = ExitStates.OPEN_CONNECTED;
					room.GridPosition = new Point(room.GridPosition.x, room.GridPosition.y - 1);
					break;
				case Direction.SOUTH:
					m_SouthExit = ExitStates.OPEN_CONNECTED;
					room.NorthExit = ExitStates.OPEN_CONNECTED;
					room.GridPosition = new Point(room.GridPosition.x, room.GridPosition.y + 1);
					break;
				case Direction.EAST:
					m_EastExit = ExitStates.OPEN_CONNECTED;
					room.WestExit = ExitStates.OPEN_CONNECTED;
					room.GridPosition = new Point(room.GridPosition.x + 1, room.GridPosition.y);
					break;
				case Direction.WEST:
					m_WestExit = ExitStates.OPEN_CONNECTED;
					room.EastExit = ExitStates.OPEN_CONNECTED;
					room.GridPosition = new Point(room.GridPosition.x - 1, room.GridPosition.y);
					break;
			}
			
			room.Divergence = m_Divergence + 1;
			
			return room;
		}
		
		public function CheckForAdjacency(room:Room):void
		{
			if (m_GridPosition.x == room.GridPosition.x)
			{
				if (m_GridPosition.y - 1 == room.GridPosition.y)
				{
					m_NorthExit = ExitStates.OPEN_CONNECTED;
					room.SouthExit = ExitStates.OPEN_CONNECTED;
					m_NorthRoom = room;
					room.SouthRoom = this;
				}
				
				if (m_GridPosition.y + 1 == room.GridPosition.y)
				{
					m_SouthExit = ExitStates.OPEN_CONNECTED;
					room.NorthExit = ExitStates.OPEN_CONNECTED;
					m_SouthRoom = room;
					room.NorthRoom = this;
				}
			}
			
			if (m_GridPosition.y == room.GridPosition.y)
			{
				if (m_GridPosition.x - 1 == room.GridPosition.x)
				{
					m_WestExit = ExitStates.OPEN_CONNECTED;
					room.EastExit = ExitStates.OPEN_CONNECTED;
					m_WestRoom = room;
					room.EastRoom = this;
				}
				
				if (m_GridPosition.x + 1 == room.GridPosition.x)
				{
					m_EastExit = ExitStates.OPEN_CONNECTED;
					room.WestExit = ExitStates.OPEN_CONNECTED;
					m_EastRoom = room;
					room.WestRoom = this;
				}
			}
		}
		
		public function CheckAtExit(rectangle:Rectangle):int
		{
			if (checkAtExit(rectangle, m_NorthSpawnBlocks))
			{
				return Direction.NORTH;
			}
			
			if (checkAtExit(rectangle, m_SouthSpawnBlocks))
			{
				return Direction.SOUTH;
			}
			
			if (checkAtExit(rectangle, m_EastSpawnBlocks))
			{
				return Direction.EAST;
			}
			
			if (checkAtExit(rectangle, m_WestSpawnBlocks))
			{
				return Direction.WEST;
			}
			
			return -1;
		}
		
		private function checkAtExit(rectangle:Rectangle, spawnBlocks:Vector.<Rectangle>):Boolean
		{
			for each(var exitBlock:Rectangle in spawnBlocks)
			{
				if (exitBlock.intersects(rectangle))
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function GetConnection(exit:int):Room
		{
			switch(exit)
			{
				case Direction.NORTH:
					return m_NorthRoom
					break;
				case Direction.SOUTH:
					return m_SouthRoom;
					break;
				case Direction.EAST:
					return m_EastRoom;
					break;
				case Direction.WEST:
					return m_WestRoom;
					break;
				default:
					return m_NorthRoom;
					break;
			}
		}
		
		public function GetSpawnBlocks(exit:int):Vector.<Rectangle>
		{
			switch(exit)
			{
				case Direction.NORTH:
					return m_NorthSpawnBlocks;
					break;
				case Direction.SOUTH:
					return m_SouthSpawnBlocks;
					break;
				case Direction.EAST:
					return m_EastSpawnBlocks;
					break;
				case Direction.WEST:
					return m_WestSpawnBlocks;
					break;
				default:
					return m_NorthSpawnBlocks;
					break;
			}
		}
		
		public function SetRoomState(roomState:int):void
		{
			m_RoomState = roomState;
		}
		
		public function set Divergence(divergence:int):void
		{
			m_Divergence = divergence;
		}
		
		public function get Divergence():int
		{
			return m_Divergence;
		}
		
		public function get NorthExit():int
		{
			return m_NorthExit;
		}
		
		public function set NorthExit(northExit:int):void
		{
			m_NorthExit = northExit;
		}
		
		public function get SouthExit():int
		{
			return m_SouthExit;
		}
		
		public function set SouthExit(southExit:int):void
		{
			m_SouthExit = southExit;
		}
		
		public function get EastExit():int
		{
			return m_EastExit;
		}
		
		public function set EastExit(eastExit:int):void
		{
			m_EastExit = eastExit;
		}
		
		public function get WestExit():int
		{
			return m_WestExit;
		}
		
		public function set WestExit(westExit:int):void
		{
			m_WestExit = westExit;
		}
		
		public function get HasAvailableConnection():Boolean
		{
			return m_NorthExit == ExitStates.CLOSED_AVAILABLE || m_SouthExit == ExitStates.CLOSED_AVAILABLE ||
				m_EastExit == ExitStates.CLOSED_AVAILABLE || m_WestExit == ExitStates.CLOSED_AVAILABLE;
		}
		
		public function get Position():Point
		{
			return new Point(m_GridPosition.x * Size.x, m_GridPosition.y * Size.y);
		}
		
		public function get GridPosition():Point
		{
			return new Point(m_GridPosition.x, m_GridPosition.y);
		}
		
		public function set GridPosition(gridPosition:Point):void
		{
			m_GridPosition = gridPosition;
		}
		
		public function get Size():Point
		{
			return new Point(m_RoomSize.x * State_Gameplay.TILE_SIZE, m_RoomSize.y * State_Gameplay.TILE_SIZE);
		}
		
		public function get GridSize():Point
		{
			return new Point(m_RoomSize.x, m_RoomSize.y);
		}
		
		public function set NorthRoom(room:Room):void
		{
			m_NorthRoom = room;
		}
		
		public function set SouthRoom(room:Room):void
		{
			m_SouthRoom = room;
		}
		
		public function set EastRoom(room:Room):void
		{
			m_EastRoom = room;
		}
		
		public function set WestRoom(room:Room):void
		{
			m_WestRoom = room;
		}
		
		public function get RoomIndex():int
		{
			return m_RoomIndex;
		}
		
		public function get TileMap():Array
		{
			return m_RoomArray;
		}
		
		public function GetRoomInformation():RoomInfo
		{
			return new RoomInfo(m_GridPosition.x, m_GridPosition.y, m_RoomState);
		}
		
		public function get NumEnemies():int
		{
			return m_NumEnemies;
		}
	}
}