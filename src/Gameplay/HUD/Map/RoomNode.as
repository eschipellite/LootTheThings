package Gameplay.HUD.Map 
{
	import flash.display.Sprite;
	import Gameplay.HUD.EmbeddedImages_HUD;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class RoomNode extends Sprite
	{
		private var m_Image:Image;
		
		private var m_X:int;
		private var m_Y:int;
		
		public function RoomNode() 
		{
			
		}
		
		public function Initialize(x:int, y:int, roomState:int):void
		{
			m_Image = ImageLoader.GetImage(EmbeddedImages_HUD.HUD_Map_Nodes);
			m_Image.Frame = roomState;
			
			m_X = x;
			m_Y = y;
			
			this.addChild(m_Image);
		}
		
		public function SetRoomState(roomState:int):void
		{
			m_Image.Frame = roomState;
		}
		
		public function get X():int
		{
			return m_X;
		}
		
		public function get Y():int
		{
			return m_Y;
		}
	}
}