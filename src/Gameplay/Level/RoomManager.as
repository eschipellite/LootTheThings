package Gameplay.Level 
{
	import flash.desktop.InteractiveIcon;
	import flash.display.Sprite;
	import flash.events.NativeWindowBoundsEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import General.Embedded_Content.EmbeddedFiles_General;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class RoomManager extends Sprite
	{	
		private var m_RoomTypes:Vector.<String>;
		private var m_Rooms:Vector.<Room>;
		
		private var m_StartRoomType:String;
		private var m_StartRoomBounds:Rectangle;
		
		private var m_Divergence:int = 5;
		private var m_CurrentDivergence:int;
		private var m_TotalRooms:int = 10;
		
		public static const RoomOffset:Point = new Point(0, 8);
		
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
			
		}
		
		public function Begin():void
		{
			reset();
			
			createRooms();
			initializeRooms();
		}
		
		public function Leave():void
		{
			reset();
		}
		
		public function Update():void
		{
			
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
			m_CurrentDivergence = m_Divergence;
			
			var firstRoom:Room = new Room();
			firstRoom.SetRoomType(m_StartRoomType);
			m_Rooms.push(firstRoom);
			
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
							updateConnections(newRoom);
							
							m_Rooms.push(newRoom);
							
							roomCreated = true;
							
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
	}
}