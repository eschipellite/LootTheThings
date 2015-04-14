package Classes.Onslaught 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	import Utils.InputContent.Controllers.ControllerInput;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class OnslaughtSword extends Sprite
	{
		private var m_Image:Image;
		
		private var m_CenterOffset:Point;
		
		public function OnslaughtSword() 
		{
			
		}	
		
		public function Initialize(centerOffset:Point):void
		{
			m_CenterOffset = centerOffset;
			
			m_Image = ImageLoader.GetImage(EmbeddedImages_Onslaught.Onslaught_Sword);
			m_Image.x = m_CenterOffset.x - m_Image.FrameWidth * 0.5;
			m_Image.y = m_CenterOffset.y - m_Image.FrameHeight * 0.5;
			
			this.addChild(m_Image);
		}
		
		public function SetRotation(rotation:Number):void
		{
			var radianRotation:Number = UtilMethods.DegreeToRadian(rotation);
			
			m_Image.x = m_CenterOffset.x - m_Image.FrameWidth * 0.5 + Math.cos(radianRotation);
			m_Image.y = m_CenterOffset.y - m_Image.FrameHeight * 0.5 + Math.sin(radianRotation);
			
			m_Image.Rotation = rotation;
		}
	}
}