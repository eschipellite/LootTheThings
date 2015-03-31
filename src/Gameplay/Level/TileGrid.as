package Gameplay.Level 
{
	import flash.geom.Point;
	import Utils.Pathfinding.AStarPathfinder;
	import Utils.Pathfinding.Connection;
	import Utils.Pathfinding.Node;
	import Utils.Pathfinding.Path;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class TileGrid 
	{	
		private var m_TileGridSize:Point;
		private var m_GridOffset:Point;
		
		private var m_TileGrid:Array = [];
		private var m_FoundationTileGrid:Array = [];
		
		private var m_Pathfinder:AStarPathfinder;
		
		private var m_AvailablePositions:Vector.<Point>;
		
		private var m_Nodes:Array = [];
		private var m_ConnectionMap:Array = [];
		private var m_Connections:Vector.<Connection>;
		
		private var m_TileSize:int;
		private var m_InvertTileSize:Number;
		
		public function TileGrid() 
		{
			m_Pathfinder = new AStarPathfinder();
			m_AvailablePositions = new Vector.<Point>();
			m_Connections = new Vector.<Connection>();
		}
		
		public function SetTileGrid(tileGrid:Array, gridSize:Point, gridOffset:Point, tileSize:int):void
		{
			m_TileGridSize = gridSize;
			m_GridOffset = gridOffset;
			
			m_TileSize = tileSize;
			m_InvertTileSize = 1 / m_TileSize;
			
			m_TileGrid = UtilMethods.Clone(tileGrid);
			
			setFoundationGridToCurrentGrid();
			
			RefreshAvailablePositions();
			
			refreshPathing();
		}
		
		private function populateTileGrid():void
		{
			for (var i:int = 0; i < m_TileGridSize.y; i++)
			{
				m_TileGrid[i] = new Array();
				
				for (var j:int = 0; j < m_TileGridSize.x; j++)
				{
					m_TileGrid[i][j] = 0;
				}
			}
		}
		
		private function setCurrentGridToFoundationGrid():void
		{
			m_TileGrid = UtilMethods.Clone(m_FoundationTileGrid);
		}
		
		private function setFoundationGridToCurrentGrid():void
		{
			m_FoundationTileGrid = UtilMethods.Clone(m_TileGrid);
		}
		
		private function initializeNodes():void
		{
			for (var row:int = 0; row < m_TileGrid.length; row++)
			{
				m_Nodes[row] = new Array();
				
				for (var col:int = 0; col < m_TileGrid[row].length; col++)
				{
					m_Nodes[row][col] = new Node(col, row, m_TileSize, m_GridOffset.x, m_GridOffset.y);
				}
			}
		}
		
		private function initializeConnections():void
		{
			for (var row:int = 0; row < m_TileGrid.length; row++)
			{
				m_ConnectionMap[row] = new Array();
				
				for (var col:int = 0; col < m_TileGrid[row].length; col++)
				{
					var adjacenies:Vector.<Point> = getAdjacentIndices(new Point(col, row));
					
					var tempConnections:Vector.<Connection> = new Vector.<Connection>();
					
					for (var adjIndex:int = 0; adjIndex < adjacenies.length; adjIndex++)
					{
						if (m_TileGrid[int(adjacenies[adjIndex].y)][int(adjacenies[adjIndex].x)] == 0)
						{
							var toNode:Node = m_Nodes[int(adjacenies[adjIndex].y)][int(adjacenies[adjIndex].x)];
							
							var tempConnection:Connection;
							
							tempConnection = new Connection(m_Nodes[row][col], toNode, 1);
							
							m_Connections.push(tempConnection);
							tempConnections.push(tempConnection);
						}
					}
					
					m_ConnectionMap[row][col] = tempConnections;
				}
			}
		}
		
		private function getAdjacentIndices(index:Point):Vector.<Point>
		{
			var indices:Vector.<Point> = new Vector.<Point>();
			
			//Diagonol
			//var xMods:Array = [0, 1, 1, 1, 0, -1, -1, -1];
			//var yMods:Array = [ -1, -1, 0, 1, 1, 1, 0, -1];
			
			//Directional
			var xMods:Array = [0, 1, 0, -1];
			var yMods:Array = [ -1, 0, 1, 0];
			
			for (var i:int = 0; i < xMods.length; i++)
			{
				var adjX:int = int(index.x + xMods[i]);
				var adjY:int = int(index.y + yMods[i]);
				
				if (adjX >= 0 && adjX < m_TileGridSize.x && adjY >= 0 && adjY < m_TileGridSize.y)
				{
					indices.push(new Point(adjX, adjY));
				}
			}
			
			return indices;
		}
		
		public function ConvertWorldToGrid(point:Point):Point
		{
			var offsetPosition:Point = new Point(point.x - m_GridOffset.x, point.y - m_GridOffset.y);
			
			var gridPosition:Point = new Point(Math.round(offsetPosition.x * m_InvertTileSize), Math.round(offsetPosition.y * m_InvertTileSize));
			
			return gridPosition;
		}
		
		public function ConvertGridToWorld(point:Point):Point
		{
			var worldPosition:Point = new Point(point.x * m_TileSize + m_GridOffset.x, point.y * m_TileSize + m_GridOffset.y);
			
			return worldPosition;
		}
		
		public function ValidateGridPosition(gridPosition:Point):Boolean
		{
			var gtXZero:Boolean = gridPosition.x >= 0;
			var ltXLength:Boolean = gridPosition.x < m_TileGrid[0].length;
			var gtYZero:Boolean = gridPosition.y >= 0;
			var ltYLength:Boolean = gridPosition.y < m_TileGrid.length;
			
			return gtXZero && ltXLength && gtYZero && ltYLength;
		}
		
		private function refreshPathing():void
		{
			initializeNodes();
			
			initializeConnections();
			
			m_Pathfinder.SetPathfindingInformation(m_ConnectionMap, m_TileSize);
		}
		
		public function RefreshAvailablePositions():void
		{
			m_AvailablePositions = new Vector.<Point>();
			
			for (var row:int = 0; row < m_TileGrid.length; row++)
			{
				for (var col:int = 0; col < m_TileGrid[row].length; col++)
				{
					if (m_TileGrid[row][col] == 0)
					{
						m_AvailablePositions.push(new Point(col, row));
					}
				}
			}
		}
		
		public function FindPath(worldStartPosition:Point, worldEndPosition:Point):Path
		{
			var fromGridPosition:Point = ConvertWorldToGrid(worldStartPosition);
			var toGridPosition:Point = ConvertWorldToGrid(worldEndPosition);
			
			var fromNode:Node = new Node(int(fromGridPosition.x), int(fromGridPosition.y), m_TileSize, m_GridOffset.x, m_GridOffset.y);
			var toNode:Node = new Node(int(toGridPosition.x), int(toGridPosition.y), m_TileSize, m_GridOffset.x, m_GridOffset.y);
			
			var path:Path = m_Pathfinder.FindPath(fromNode, toNode);
			
			path.SmoothPath(m_TileSize, m_TileGrid);
			
			return path;
		}
		
		public function SetPositionOccupiedFromGrid(gridPosition:Point, gridValue:int = 1):void
		{
			if (ValidateGridPosition(gridPosition))
			{
				var toRemove:int = -1;
				
				for (var i:int = 0; i < m_AvailablePositions.length; i++)
				{
					if (m_AvailablePositions[i].equals(gridPosition))
					{
						toRemove = i;
					}
				}
				
				if (toRemove >= 0)
				{
					m_AvailablePositions.splice(toRemove, 1);
				}
				
				m_TileGrid[gridPosition.y][gridPosition.x] = gridValue;
			}
		}
		
		public function SetPositionOccupiedFromWorld(worldPosition:Point, gridValue:int = 1):void
		{
			var gridPosition:Point = ConvertWorldToGrid(worldPosition);
			
			SetPositionOccupiedFromGrid(gridPosition, gridValue);
		}
		
		public function SetPositionAvailableFromGrid(gridPosition:Point):void
		{
			if (ValidateGridPosition(gridPosition))
			{
				m_AvailablePositions.push(new Point(gridPosition.x, gridPosition.y));
				
				m_TileGrid[gridPosition.y][gridPosition.x] = 0;
			}
		}
		
		public function SetPositionAvailableFromWorld(worldPosition:Point):void
		{
			var gridPosition:Point = ConvertWorldToGrid(worldPosition);
			
			SetPositionAvailableFromGrid(gridPosition);
		}
		
		public function CheckGridPositionEmpty(gridPosition:Point):Boolean
		{
			if (ValidateGridPosition(gridPosition))
			{
				return m_TileGrid[gridPosition.y][gridPosition.x] == 0;
			}
			
			return false;
		}
		
		public function CheckWorldPositionEmpty(worldPosition:Point):Boolean
		{
			var gridPosition:Point = ConvertWorldToGrid(worldPosition);
			
			return CheckGridPositionEmpty(gridPosition);
		}
		
		public function GetAvailableAdjacenies(gridPosition:Point):Vector.<Point>
		{
			var availableAdjacentPositions:Vector.<Point> = new Vector.<Point>()
			
			var rightPosition:Point = new Point(gridPosition.x + 1, gridPosition.y);
			var leftPosition:Point = new Point(gridPosition.x - 1, gridPosition.y);
			var upPosition:Point = new Point(gridPosition.x, gridPosition.y - 1);
			var downPosition:Point = new Point(gridPosition.x, gridPosition.y + 1);
			
			if (CheckGridPositionEmpty(rightPosition))
				availableAdjacentPositions.push(rightPosition);
			if (CheckGridPositionEmpty(leftPosition))
				availableAdjacentPositions.push(leftPosition);
			if (CheckGridPositionEmpty(upPosition))
				availableAdjacentPositions.push(upPosition);
			if (CheckGridPositionEmpty(downPosition))
				availableAdjacentPositions.push(downPosition);
				
			return availableAdjacentPositions;
		}
		
		public function Reset():void
		{
			m_TileGrid = UtilMethods.Clone(m_FoundationTileGrid);
			
			RefreshAvailablePositions();
		}
		
		public function GetRandomAvailableGridPosition():Point
		{
			if (m_AvailablePositions.length <= 0)
			{
				return new Point(0, 0);
			}
			
			var randomRange:int = UtilMethods.Random(0, m_AvailablePositions.length - 1);
			
			var randomPosition:Point = new Point(m_AvailablePositions[randomRange].x, m_AvailablePositions[randomRange].y);
			
			return randomPosition;
		}
		
		public function GetRandomAvailablePosition():Point
		{
			var gridPosition:Point = GetRandomAvailableGridPosition();
			
			return ConvertGridToWorld(gridPosition);
		}
		
		public function GetGridValueFromWorld(worldPosition:Point):int
		{
			var gridPosition:Point = ConvertWorldToGrid(worldPosition);
			
			return GetGridValue(gridPosition);
		}
		
		public function GetGridValue(gridPosition:Point):int
		{
			if (ValidateGridPosition(gridPosition))
			{
				return m_TileGrid[gridPosition.y][gridPosition.x];
			}
			else
			{
				return -1;
			}
		}
	}
}