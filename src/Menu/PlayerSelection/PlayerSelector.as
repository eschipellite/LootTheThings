package Menu.PlayerSelection 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Utils.InputContent.Controllers.ControllerInput;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerSelector extends Sprite
	{
		private var m_PlayerInformation:Vector.<PlayerInformation>;
		
		private var m_PlayerInformationStart:Point = new Point(64, 192);
		private var m_PlayerInformationOffset:Point = new Point(288, 0);
		
		public function PlayerSelector() 
		{
			m_PlayerInformation = new Vector.<PlayerInformation>();
		}
		
		public function Initialize():void
		{
			for (var index:int = 0; index < Main.MaxPlayers; index++)
			{
				m_PlayerInformation.push(new PlayerInformation(index));
			}
			
			createPlayerInformation();
		}
		
		private function createPlayerInformation():void
		{
			var position:Point = new Point(m_PlayerInformationStart.x, m_PlayerInformationStart.y);
			var offset:Point = new Point(m_PlayerInformationOffset.x, m_PlayerInformationOffset.y);
			for each(var playerInformation:PlayerInformation in m_PlayerInformation)
			{
				playerInformation.SetPosition(position);
				this.addChild(playerInformation);
				
				position = new Point(m_PlayerInformationStart.x + offset.x, m_PlayerInformationStart.y + offset.y);
				offset.x += m_PlayerInformationOffset.x;
				offset.y += m_PlayerInformationOffset.y;
			}
		}
		
		public function Update():void
		{
			for each(var playerInformation:PlayerInformation in m_PlayerInformation)
			{
				playerInformation.Update();
			}
		}
		
		public function Reset():void
		{
			for each(var playerInformation:PlayerInformation in m_PlayerInformation)
			{
				playerInformation.Reset();
			}
		}
	}
}