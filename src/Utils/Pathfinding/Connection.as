package Utils.Pathfinding 
{
	public class Connection 
	{
		private var m_FromNode:Node;
		private var m_ToNode:Node;
		private var m_Cost:Number;
		
		public function Connection(fromNode:Node, toNode:Node, cost:Number) 
		{
			m_FromNode = fromNode;
			m_ToNode = toNode;
			m_Cost = cost;
		}
		
		public function get FromNode():Node
		{
			return m_FromNode;
		}
		
		public function get ToNode():Node
		{
			return m_ToNode;
		}
		
		public function get Cost():Number
		{
			return m_Cost;
		}
	}
}