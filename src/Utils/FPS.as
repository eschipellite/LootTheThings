package Utils 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import Gameplay.Player.EmbeddedImages_Player;
	import Utils.GameTime;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	
	public class FPS extends Sprite
	{	
		private var m_CurrentTime:Number;
		private var m_NumFrames:Number;
		
		private var m_TextField:TextField;
		
		public function FPS() 
		{
			m_TextField = new TextField();
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.color = 0xffffff;
			
			m_TextField.defaultTextFormat = textFormat;
			
			m_CurrentTime = 0;
			m_NumFrames = 0;
			
			m_TextField.selectable = false;
			m_TextField.width = 20;
			m_TextField.height = 20;
		}
		
		public function Start():void
		{
			m_CurrentTime = 0;
			
			this.addChild(m_TextField);
			
			addEventListener(Event.ENTER_FRAME, updateFPS);
		}
		
		private function updateFPS(e:Event):void
		{
			m_CurrentTime += GameTime.ElapsedGameTimeSeconds;
			
			m_NumFrames++;
			
			if (m_CurrentTime > 1)
			{
				m_TextField.text = String(m_NumFrames);
				
				m_NumFrames = 0;
				m_CurrentTime = 0;
			}
		}
	}
}