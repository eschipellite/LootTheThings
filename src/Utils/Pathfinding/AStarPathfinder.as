package Utils.Pathfinding 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class AStarPathfinder 
	{	
		private var m_ConnectionMap:Array;
		
		private var m_HalfTileSize:int;
		
		public function AStarPathfinder() 
		{
			m_ConnectionMap = [];
		}
		
		public function SetPathfindingInformation(connectionMap:Array, tileSize:int):void
		{
			m_ConnectionMap = connectionMap;
			
			m_HalfTileSize = tileSize / 2;
		}
		
		private function getSmallestRecord(recordList:Vector.<NodeRecord>):NodeRecord
		{
			if (recordList.length == 0)
			{
				return null;
			}
			
			var lowestCost:Number = recordList[0].costSoFar;
			var smallestRecord:NodeRecord = new NodeRecord();
			
			for (var i:int = 0; i < recordList.length; i++)
			{
				if (recordList[i].costSoFar <= lowestCost)
				{
					lowestCost = recordList[i].costSoFar;
					smallestRecord = recordList[i];
				}
			}
			
			return smallestRecord;
		}
		
		private function getSmallestTotalEstimateRecord(recordList:Vector.<NodeRecord>):NodeRecord
		{
			if (recordList.length == 0)
			{
				return null;
			}
			
			var lowestEstimateCost:Number = recordList[0].estimatedCostSoFar;
			var lowestEstimateRecord:NodeRecord = new NodeRecord();
			
			for (var i:int = 0; i < recordList.length; i++)
			{
				if (recordList[i].estimatedCostSoFar <= lowestEstimateCost)
				{
					lowestEstimateCost = recordList[i].estimatedCostSoFar;
					lowestEstimateRecord = recordList[i];
				}
			}
			
			return lowestEstimateRecord;
		}
		
		private function containsNode(node:Node, recordList:Vector.<NodeRecord>):Boolean
		{
			for (var i:int = 0; i < recordList.length; i++)
			{
				if (recordList[i].node.NodeID.equals(node.NodeID))
				{
					return true;
				}
			}
			
			return false;
		}
		
		private function findNodeRecord(node:Node, recordList:Vector.<NodeRecord>):NodeRecord
		{
			for (var i:int = 0; i < recordList.length; i++)
			{
				if (recordList[i].node.NodeID.equals(node.NodeID))
				{
					return recordList[i];
				}
			}
			
			return null;
		}
		
		private function getNodeIndex(node:Node, recordList:Vector.<NodeRecord>):int
		{
			for (var i:int = 0; i < recordList.length; i++)
			{
				if (recordList[i].node.NodeID.equals(node.NodeID))
				{
					return i;
				}
			}
			
			return -1;
		}
		
		private function getHeuristic(fromNode:Node, toNode:Node):Number
		{
			var halfTileSize:int = m_HalfTileSize;
			
			var fromPoint:Point = new Point(fromNode.Position.x + halfTileSize, fromNode.Position.y + halfTileSize);
			var toPoint:Point = new Point(toNode.Position.x + halfTileSize, toNode.Position.y + halfTileSize);
			
			var distance:Number = Point.distance(fromPoint, toPoint);
			
			return distance;
		}
		
		private function getConnections(nodeID:Point):Vector.<Connection>
		{
			if (m_ConnectionMap[nodeID.y][nodeID.x] != null)
			{
				return m_ConnectionMap[nodeID.y][nodeID.x];
			}
			
			return new Vector.<Connection>();
		}
		
		public function FindPath(fromNode:Node, toNode:Node):Path
		{
			if (fromNode.NodeID == toNode.NodeID)
			{
				return new Path();
			}
			
			var tempPath:Path = new Path();
			
			var startNodeRecord:NodeRecord = new NodeRecord(fromNode, null, 0);
			startNodeRecord.estimatedCostSoFar = getHeuristic(fromNode, toNode);
			var currentRecord:NodeRecord = new NodeRecord();
			var endNodeRecord:NodeRecord = new NodeRecord();
			var endNode:Node;
			var endNodeCost:Number;
			var endNodeHeurisitc:Number;
			
			var openList:Vector.<NodeRecord> = new Vector.<NodeRecord>();
			openList.push(startNodeRecord);
			var closeList:Vector.<NodeRecord> = new Vector.<NodeRecord>();
			
			var currentConnections:Vector.<Connection>;
			
			while (openList.length > 0)
			{
				currentRecord = getSmallestTotalEstimateRecord(openList);
				
				if (currentRecord.node.NodeID.equals(toNode.NodeID))
				{
					break;
				}
				
				currentConnections = getConnections(currentRecord.node.NodeID);
				
				for (var i:int = 0; i < currentConnections.length; i++)
				{
					endNode = currentConnections[i].ToNode;
					endNodeCost = currentConnections[i].Cost + currentRecord.costSoFar;
					
					if (containsNode(endNode, closeList))
					{
						endNodeRecord = findNodeRecord(endNode, closeList);
						
						if (endNodeRecord.costSoFar <= endNodeCost)
						{
							continue;
						}
						
						closeList.splice(getNodeIndex(endNodeRecord.node, closeList), 1);
						
						endNodeHeurisitc = endNodeRecord.estimatedCostSoFar - endNodeRecord.costSoFar;
					}
					else if (containsNode(endNode, openList))
					{
						endNodeRecord = findNodeRecord(endNode, openList);
						
						if (endNodeRecord.costSoFar <= endNodeCost)
						{
							continue;
						}
						
						endNodeHeurisitc = endNodeRecord.estimatedCostSoFar - endNodeRecord.costSoFar;
					}
					else
					{
						endNodeRecord = new NodeRecord(endNode, null, endNodeCost);
						endNodeHeurisitc = getHeuristic(endNode, toNode);
					}
					
					endNodeRecord.costSoFar = endNodeCost;
					endNodeRecord.connection = currentConnections[i];
					endNodeRecord.estimatedCostSoFar = endNodeCost + endNodeHeurisitc;
					
					if (!containsNode(endNode, openList))
					{
						openList.push(endNodeRecord);
					}
				}
				
				var nodeIndex:int = getNodeIndex(currentRecord.node, openList);
				
				openList.splice(nodeIndex, 1);
				
				closeList.push(currentRecord);
			}
			
			if (!currentRecord.node.NodeID.equals(toNode.NodeID))
			{
					tempPath = new Path();
			}
			else
			{
				while (!currentRecord.node.NodeID.equals(fromNode.NodeID))
				{
					tempPath.AddNode(currentRecord.node);
						
					currentRecord = findNodeRecord(currentRecord.connection.FromNode, closeList);
				}
					
				tempPath.AddNode(fromNode);
					
				tempPath.Reverse();
			}
				
			openList = new Vector.<NodeRecord>();
			closeList = new Vector.<NodeRecord>();
				
			return tempPath;
		}
	}
}