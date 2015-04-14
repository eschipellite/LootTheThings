package Classes.Onslaught 
{
	import flash.geom.Point;
	import Gameplay.Player.Player;
	import Utils.ImageContent.ImageLoader;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class Onslaught extends Player
	{
		private var m_OnslaughtSword:OnslaughtSword;
		
		public function Onslaught() 
		{
			m_OnslaughtSword = new OnslaughtSword();
		}
		
		override public function Initialize(index:int):void 
		{
			super.Initialize(index);
			
			var centerOffset:Point = this.Size;
			centerOffset.x *= 0.5;
			centerOffset.y *= 0.5;
			m_OnslaughtSword.Initialize(centerOffset);
			
			this.addChild(m_OnslaughtSword);
		}
		
		protected override function loadImages():void
		{
			m_Image_Player = ImageLoader.GetImage(EmbeddedImages_Onslaught.Onslaught_Player);
		}
		
		public override function Update():void
		{
			super.Update();
		}
		
		protected override function checkRotationInput():void
		{
			super.checkRotationInput();
			
			m_OnslaughtSword.SetRotation(m_Image_Player.rotation);
		}
	}
}