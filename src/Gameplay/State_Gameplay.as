package Gameplay 
{
	import flash.display.Sprite;
	import Gameplay.Player.Player;
	import Gameplay.Player.PlayerHandler;
	import General.States.GameState;
	/**
	 * ...
	 * @author EvanSchipellite
	 */
	public class State_Gameplay extends GameState
	{		
		private var m_PlayerHandler:PlayerHandler;
		
		public function State_Gameplay() 
		{
			m_PlayerHandler = new PlayerHandler();
		}
		
		public override function Initialize():void
		{
			m_PlayerHandler.Initialize();
			
			this.addChild(m_PlayerHandler);
		}
		
		public override function InitializeEventListeners():void
		{
			m_PlayerHandler.InitializeEventListeners();
		}
		
		public override function Update():void
		{
			m_PlayerHandler.Update();
		}
		
		public override function Begin():void
		{
			
		}
		
		public override function Leave():void
		{
			
		}
	}
}