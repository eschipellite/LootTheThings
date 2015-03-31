package Utils.Pathfinding 
{
	import flash.geom.Point;
	
	public class Node 
	{
		private var m_NodeIDX:int;
		private var m_NodeIDY:int;
		
		private var m_NodePositionX:int;
		private var m_NodePositionY:int;
		
		public function Node(nodeIDX:int, nodeIDY:int, tileSize:int, worldOffsetX:int = 0, worldOffsetY:int = 0) 
		{
			m_NodeIDX = nodeIDX;
			m_NodeIDY = nodeIDY;
			
			m_NodePositionX = m_NodeIDX * tileSize + worldOffsetX;
			m_NodePositionY = m_NodeIDY * tileSize + worldOffsetY;
		}
		
		public function get NodeID():Point
		{
			return new Point(m_NodeIDX, m_NodeIDY);
		}
		
		public function get Position():Point
		{
			return new Point(m_NodePositionX, m_NodePositionY);
		}
	}
}