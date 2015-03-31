package Utils.Pathfinding 
{
	public class NodeRecord 
	{		
		public var node:Node;
		public var connection:Connection;
		public var costSoFar:Number;
		public var estimatedCostSoFar:Number;
		
		public function NodeRecord(node:Node=null, connection:Connection=null, costSoFar:Number=0)
		{
			this.node = node;
			this.connection = connection;
			this.costSoFar = costSoFar;
			estimatedCostSoFar = 0;
		}
	}
}