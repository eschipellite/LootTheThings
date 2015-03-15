package Gameplay.HUD.Map 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Gameplay.HUD.EmbeddedImages_HUD;
	import Gameplay.Level.Direction;
	import Gameplay.Level.RoomInfo;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class HUDMap extends Sprite
	{
		private var m_Background:Image;
		
		private var m_RoomNodes:Vector.<RoomNode>;
		
		private var m_MapSize:Point;
		private var m_NodeSize:int = 16;
		
		public function HUDMap() 
		{
			m_RoomNodes = new Vector.<RoomNode>();
			m_MapSize = new Point(0, 0);
		}
		
		public function Initialize():void
		{
			m_Background = ImageLoader.GetImage(EmbeddedImages_HUD.HUD_Map_Background);
			
			m_MapSize.x = m_Background.FrameWidth;
			m_MapSize.y = m_Background.FrameHeight;
			
			this.scrollRect = new Rectangle(0, 0, m_Background.FrameWidth, m_Background.FrameHeight);
			
			this.addChild(m_Background);
		}
		
		public function SetRoomInformation(roomInformation:Vector.<RoomInfo>):void
		{
			reset();
			
			for each(var roomInfo:RoomInfo in roomInformation)
			{
				var roomNode:RoomNode = new RoomNode();
				roomNode.Initialize(roomInfo.X, roomInfo.Y, roomInfo.RoomState);
				var gridPosition:Point = new Point(roomInfo.X, roomInfo.Y);
				roomNode.x = m_MapSize.x * 0.5 - m_NodeSize * 0.5 + gridPosition.x * m_NodeSize;
				roomNode.y = m_MapSize.y * 0.5 - m_NodeSize * 0.5 + gridPosition.y * m_NodeSize;
				m_RoomNodes.push(roomNode);
				this.addChild(roomNode);
			}
		}
		
		public function SetRoomInfo(roomInfo:RoomInfo):void
		{
			for each(var roomNode:RoomNode in m_RoomNodes)
			{
				if (roomInfo.X == roomNode.X && roomInfo.Y == roomNode.Y)
				{
					roomNode.SetRoomState(roomInfo.RoomState);
				}
			}
		}
		
		public function ChangeRoom(direction:int):void
		{
			var adjust:Point = new Point(0, 0);
			
			switch(direction)
			{
				case Direction.NORTH:
					adjust.y = 1;
					break;
				case Direction.SOUTH:
					adjust.y = -1;
					break;
				case Direction.EAST:
					adjust.x = -1;
					break;
				case Direction.WEST:
					adjust.x = 1;
					break;
			}
			
			adjust.x *= m_NodeSize;
			adjust.y *= m_NodeSize;
			
			for each(var roomNode:RoomNode in m_RoomNodes)
			{
				roomNode.x += adjust.x;
				roomNode.y += adjust.y;
			}
		}
		
		private function reset():void
		{
			for each(var roomNode:RoomNode in m_RoomNodes)
			{
				if (this.contains(roomNode))
				{
					this.removeChild(roomNode);
				}
			}
			
			m_RoomNodes = new Vector.<RoomNode>();
		}
	}
}