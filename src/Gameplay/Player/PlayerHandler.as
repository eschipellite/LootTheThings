package Gameplay.Player 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerHandler extends Sprite
	{
		private static const MAX_PLAYERS:int = 4;
		
		private var m_Players:Vector.<Player>;
		
		public function PlayerHandler() 
		{
			m_Players = new Vector.<Player>();
		}
		
		public function Initialize():void
		{
			createPlayers();
		}
		
		public function InitializeEventListeners():void
		{
			
		}
		
		public function Update():void
		{
			for each(var player:Player in m_Players)
			{
				player.Update();
			}
		}
		
		private function createPlayers():void
		{
			for (var index:int = 0; index < MAX_PLAYERS; index++)
			{
				var player:Player = new Player();
				
				player.Initialize(index);
				player.SetPosition(getRandomPlayerPosition(player.Size));
				
				m_Players.push(player);
				this.addChild(player);
			}
		}
		
		private function getRandomPlayerPosition(playerSize:Point):Point
		{
			var screenPosition:Point = new Point(0, 0);
			
			screenPosition.x = UtilMethods.RandomRange(0, Main.ScreenArea.x - playerSize.x);
			screenPosition.y = UtilMethods.RandomRange(0, Main.ScreenArea.y - playerSize.y);
			
			return screenPosition;
		}
	}
}