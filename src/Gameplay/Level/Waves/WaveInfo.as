package Gameplay.Level.Waves 
{
	import flash.geom.Point;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class WaveInfo 
	{
		private var m_Waves:Vector.<Wave>;
		
		private var m_GridSpawnLocations:Vector.<Point>;
		
		private var m_CurrentWaveIndex:int;
		
		public function WaveInfo() 
		{
			m_Waves = new Vector.<Wave>();
			m_GridSpawnLocations = new Vector.<Point>();
			m_CurrentWaveIndex = 0;
		}
		
		public function SetWaves(waves:Vector.<Wave>):void
		{
			m_Waves = waves;
		}
		
		public function AddWave(wave:Wave):void
		{
			m_Waves.push(wave);
		}
		
		public function AddGridSpawnLocation(gridSpawnLocation:Point):void
		{
			m_GridSpawnLocations.push(gridSpawnLocation);
		}
		
		public function SetGridSpawnLocations(gridSpawnLocations:Vector.<Point>):void
		{
			m_GridSpawnLocations = gridSpawnLocations;
		}
		
		public function Reset():void
		{
			m_CurrentWaveIndex = 0;
		}
		
		public function get CurrentEnemies():int
		{
			return m_Waves[m_CurrentWaveIndex].NumEnemies;
		}
		
		public function get CurrentDuration():Number
		{
			return m_Waves[m_CurrentWaveIndex].Duration;
		}
		
		public function get Active():Boolean
		{
			return m_CurrentWaveIndex < m_Waves.length;
		}
		
		public function IncrementWave():void
		{
			m_CurrentWaveIndex++;
		}
		
		public function GetRandomGridSpawnLocation():Point
		{
			var randomIndex:int = UtilMethods.Random(0, m_GridSpawnLocations.length - 1, UtilMethods.ROUND);
			
			return new Point(m_GridSpawnLocations[randomIndex].x, m_GridSpawnLocations[randomIndex].y);
		}
	}
}