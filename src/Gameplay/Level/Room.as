package Gameplay.Level 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import Gameplay.EmbeddedImages_Gameplay;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class Room extends Sprite
	{
		private static var m_TileSize:int = 64;
		
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
		}
		
		public function Initialize():void
		{
			m_RoomArray = UtilMethods.StringTo2DArray(m_RoomType);
			m_RoomSize = new Point(m_RoomArray[0].length, m_RoomArray.length);
			
			createExits();
			createTiles();
		}
		
		public function SetRoomType(roomType:String):void
		{
			m_RoomType = roomType;
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
				m_RoomArray[row][0] = tempArray[row];
			}
		}
		
		private function createWestExit():void
		{
			var tempArray:Array = [1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1];
			
			for (var row:int = 0; row < m_RoomArray.length; row++)
			{
				m_RoomArray[row][m_RoomSize.x - 1] = tempArray[row];
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
					
					tileImage.x = col * m_TileSize;
					tileImage.y = row * m_TileSize;
					
					tileBitmapData.copyPixels(tileImage.bitmapData, tileImage.scrollRect, new Point(tileImage.x, tileImage.y));
				}
			}
			
			m_TileMap = new Image(tileBitmapData);
			m_TileMap.x = RoomManager.RoomOffset.x;
			m_TileMap.y = RoomManager.RoomOffset.y;
			
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
					room.GridPosition = new Point(room.GridPosition.x - 1, room.GridPosition.y);
					break;
				case Direction.WEST:
					m_WestExit = ExitStates.OPEN_CONNECTED;
					room.EastExit = ExitStates.OPEN_CONNECTED;
					room.GridPosition = new Point(room.GridPosition.x + 1, room.GridPosition.y);
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
				if (m_GridPosition.x + 1 == room.GridPosition.x)
				{
					m_WestExit = ExitStates.OPEN_CONNECTED;
					room.EastExit = ExitStates.OPEN_CONNECTED;
					m_WestRoom = room;
					room.EastRoom = this;
				}
				
				if (m_GridPosition.x - 1 == room.GridPosition.x)
				{
					m_EastExit = ExitStates.OPEN_CONNECTED;
					room.WestExit = ExitStates.OPEN_CONNECTED;
					m_EastRoom = room;
					room.WestRoom = this;
				}
			}
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
			return new Point(m_RoomSize.x * m_TileSize, m_RoomSize.y * m_TileSize);
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
	}
}