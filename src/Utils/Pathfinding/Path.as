package Utils.Pathfinding 
{
	import flash.geom.Point;
	public class Path 
	{	
		private var m_Nodes:Vector.<Node>;
		
		public function Path() 
		{
			Clear();
		}
		
		public function Clear():void
		{
			m_Nodes = new Vector.<Node>();
		}
		
		public function SetPath(path:Path):void
		{
			Clear();
			
			if (path != null)
			{
				m_Nodes = path.GetNodes();
			}
		}
		
		public function SmoothPath(tileSize:int, collisionMap:Array):void
		{
			var inputIndex:int = 2;
			
			var smoothPath:Path = new Path();
			
			if (this.NumNodes <= 2)
			{
				for (var i:int = 0; i < this.NumNodes; i++)
				{
					smoothPath.AddNode(m_Nodes[i]);
				}
			}
			else
			{
				smoothPath.AddNode(m_Nodes[0]);
				
				while (inputIndex < this.NumNodes)
				{
					var lastTopLeft:Node = new Node(smoothPath.GetNodes()[smoothPath.NumNodes - 1].NodeID.x - 0.5, smoothPath.GetNodes()[smoothPath.NumNodes - 1].NodeID.y - 0.5, tileSize);
					var lastTopRight:Node = new Node(smoothPath.GetNodes()[smoothPath.NumNodes - 1].NodeID.x + 0.5, smoothPath.GetNodes()[smoothPath.NumNodes - 1].NodeID.y - 0.5, tileSize);
					var lastBottomLeft:Node = new Node(smoothPath.GetNodes()[smoothPath.NumNodes - 1].NodeID.x - 0.5, smoothPath.GetNodes()[smoothPath.NumNodes - 1].NodeID.y + 0.5, tileSize);
					var lastBottomRight:Node = new Node(smoothPath.GetNodes()[smoothPath.NumNodes - 1].NodeID.x + 0.5, smoothPath.GetNodes()[smoothPath.NumNodes - 1].NodeID.y + 0.5, tileSize);
					
					var topLeft:Node = new Node(m_Nodes[inputIndex].NodeID.x - 0.5, m_Nodes[inputIndex].NodeID.y - 0.5, tileSize);
					var topRight:Node = new Node(m_Nodes[inputIndex].NodeID.x + 0.5, m_Nodes[inputIndex].NodeID.y - 0.5, tileSize);
					var bottomLeft:Node = new Node(m_Nodes[inputIndex].NodeID.x - 0.5, m_Nodes[inputIndex].NodeID.y + 0.5, tileSize);
					var bottomRight:Node = new Node(m_Nodes[inputIndex].NodeID.x + 0.5, m_Nodes[inputIndex].NodeID.y + 0.5, tileSize);
					
					if (!RayClear(lastTopLeft, topLeft, tileSize, collisionMap) ||
						!RayClear(lastTopRight, topRight, tileSize, collisionMap) ||
						!RayClear(lastBottomLeft, bottomLeft, tileSize, collisionMap) ||
						!RayClear(lastBottomRight, bottomRight, tileSize, collisionMap))
					{
						smoothPath.AddNode(m_Nodes[inputIndex - 1]);
					}
					
					inputIndex++;
				}
				
				smoothPath.AddNode(m_Nodes[m_Nodes.length - 1]);
			}
			
			SetPath(smoothPath);
		}
		
		public function GetNodes():Vector.<Node>
		{
			return m_Nodes;
		}
		
		public function get NumNodes():int
		{
			return m_Nodes.length;
		}
		
		public function PeekNode(nodeIndex:int):Node
		{
			if (nodeIndex < m_Nodes.length)
			{
				return m_Nodes[nodeIndex];
			}
			else
			{
				return null;
			}
		}
		
		public function PeekNextNode():Node
		{
			if (m_Nodes.length > 0)
			{
				return m_Nodes[m_Nodes.length - 1];
			}
			else
			{
				return null;
			}
		}
		
		public function GetAndRemoveNextNode():Node
		{
			if (m_Nodes.length > 0)
			{
				var returnNode:Node = m_Nodes.pop();
				
				return returnNode;
			}
			else
			{
				return null;
			}
		}
		
		public function AddNode(node:Node):void
		{
			m_Nodes.push(node);
		}
		
		public function ContainsNode(node:Node):Boolean
		{
			var nodeFound:Boolean = false;
			
			for (var i:int = 0; i < m_Nodes.length; i++)
			{
				if (m_Nodes[i].NodeID.equals(node.NodeID))
				{
					nodeFound = true;
					break;
				}
			}
			
			return nodeFound;
		}
		
		public function Reverse():void
		{
			m_Nodes.reverse();
		}
		
		public function CheckNodes():Boolean
		{
			if (m_Nodes == null || m_Nodes.length == 0)
			{
				return false;
			}
			
			return true;
		}
		
		//Grid RayCast Assistance From http://playtechs.blogspot.com/2007/03/raytracing-on-grid.html
		public function RayClear(startNode:Node, endNode:Node, tileSize:int, collisionMap:Array):Boolean
		{
			var startPosition:Point = new Point(startNode.NodeID.x + 0.5, startNode.NodeID.y + 0.5);
			var endPosition:Point = new Point(endNode.NodeID.x + 0.5, endNode.NodeID.y + 0.5);
			var dx:int = Math.abs(int(endPosition.x) - int(startPosition.x));
			var dy:int = Math.abs(int(endPosition.y) - int(startPosition.y));
			var currentX:int = int(startPosition.x);
			var currentY:int = int(startPosition.y);
			var n:int = 1 + (dx + dy);
			var incrementX:int = (endPosition.x > startPosition.x) ? 1 : -1;
			var incrementY:int = (endPosition.y > startPosition.y) ? 1 : -1;
			var diff:int = dx - dy;
			dx *= 2;
			dy *= 2;
			
			while (n > 0)
			{
				if (collisionMap[currentY][currentX] == 1)
				{
					return false;
				}
				
				if (diff > 0)
				{
					currentX += incrementX;
					diff -= dy;
				}
				else
				{
					currentY += incrementY;
					diff += dx;
				}
				
				--n;
			}
			
			return true;
		}
	}
}