package Gameplay.Enemy 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Gameplay.Enemy.Events.SpawnEnemiesEvent;
	import Gameplay.Level.Room;
	import Gameplay.Level.RoomManager;
	import Gameplay.Level.TileValues;
	import Gameplay.State_Gameplay;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class EnemyManager extends Sprite
	{
		private var m_Enemies:Vector.<Enemy>;
		
		public function EnemyManager() 
		{
			m_Enemies = new Vector.<Enemy>();
		}
		
		public function Initialize():void
		{
		}
		
		public function InitializeEventListeners():void
		{
			State_Gameplay.eventDispatcher.addEventListener(SpawnEnemiesEvent.SPAWN_ENEMIES_EVENT, eh_SpawnEnemiesEvent);
		}
		
		public function Update():void
		{
			updateEnemies();
		}
		
		public function Begin():void
		{
		}
		
		public function Leave():void
		{
			reset();
		}
		
		private function reset():void
		{
			for each(var enemy:Enemy in m_Enemies)
			{
				this.removeChild(enemy);
			}
			
			m_Enemies = new Vector.<Enemy>();
		}
		
		private function eh_SpawnEnemiesEvent(evt:SpawnEnemiesEvent):void
		{	
			reset();
			
			spawnEnemies();
		}
		
		private function spawnEnemies():void
		{
			for (var index:int = 0; index < RoomManager.CurrentRoom.NumEnemies; index++)
			{
				var enemy:Enemy = new Enemy();
				enemy.Initialize(RoomManager.CurrentRoom.GridPosition, RoomManager.CurrentRoom.Size);
				
				var position:Point = RoomManager.CurrentTileGrid.GetRandomAvailablePosition();
				enemy.x = position.x;
				enemy.y = position.y;
				
				this.addChild(enemy);
				m_Enemies.push(enemy);
			}
		}
		
		private function updateEnemies():void
		{
			for each(var enemy:Enemy in m_Enemies)
			{
				enemy.Update();
			}
		}
	}
}