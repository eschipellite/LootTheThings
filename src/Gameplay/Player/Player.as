package Gameplay.Player 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.GameInput;
	import flash.ui.GameInputControl;
	import Gameplay.Player.Events.PlayerCollisionEvent;
	import Gameplay.State_Gameplay;
	import Utils.GameTime;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	import Utils.InputContent.Controllers.ControllerInput;
	import Utils.InputContent.Controllers.GameController;
	import Utils.Output.Console;
	/**
	 * ...
	 * @author ...
	 */
	public class Player extends Sprite
	{
		private var m_Image_Player:Image;
		
		private var m_Index:int;
		
		private var m_Speed:int = 256;
		
		public function Player() 
		{
			m_Index = -1;
		}
		
		public function Initialize(index:int):void
		{
			m_Index = index;
			
			m_Image_Player = ImageLoader.GetImage(EmbeddedImages_Player.Player_Player);
			m_Image_Player.Frame = m_Index;
			
			this.addChild(m_Image_Player);
		}
		
		public function Update():void
		{
			checkInput();
			
			checkCollectibleCollision();
		}
		
		private function checkCollectibleCollision():void
		{
			State_Gameplay.eventDispatcher.dispatchEvent(new PlayerCollisionEvent(PlayerCollisionEvent.CHECK_COLLECTIBLE_COLLISION_EVENT, this));
		}
		
		private function checkInput():void
		{
			var movement:Point = ControllerInput.GetController(m_Index).LeftStick;
			
			m_Image_Player.x += movement.x * GameTime.ElapsedGameTimeSeconds * m_Speed;
			m_Image_Player.y += movement.y * GameTime.ElapsedGameTimeSeconds * m_Speed;
		}
		
		public function SetPosition(position:Point):void
		{
			m_Image_Player.x = position.x;
			m_Image_Player.y = position.y;
		}
		
		public function get Size():Point
		{
			return new Point(m_Image_Player.FrameWidth, m_Image_Player.FrameHeight);
		}
		
		public function get CollisionBounds():Rectangle
		{
			return m_Image_Player.CollisionBounds;
		}
		
		public function get Index():int
		{
			return m_Index;
		}
	}
}