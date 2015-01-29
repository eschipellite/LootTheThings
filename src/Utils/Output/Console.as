package Utils.Output 
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flashx.textLayout.formats.TextAlign;
	import Utils.Output.Events.ConsoleEvent;
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class Console extends Sprite
	{
		private static var g_EventDispatcher:IEventDispatcher = new EventDispatcher();
		
		private var m_ConsoleText:TextField;
		
		private var m_ConsoleLines:Vector.<ConsoleLine>;
		
		public function Console() 
		{
			m_ConsoleText = new TextField();
			
			m_ConsoleLines = new Vector.<ConsoleLine>();
		}
		
		public function Initialize():void
		{
			var textFormat:TextFormat = new TextFormat();
			//textFormat.align = TextFormatAlign.RIGHT;
			textFormat.size = 36;
			
			m_ConsoleText.defaultTextFormat = textFormat;
			
			m_ConsoleText.width = Main.StageSize.x;
			//m_ConsoleText.autoSize = "right";
			
			m_ConsoleText.wordWrap = true;
			m_ConsoleText.selectable = false;
			
			this.addChild(m_ConsoleText);
		}
		
		public function InitializeEventListeners():void
		{
			eventDispatcher.addEventListener(ConsoleEvent.WRITE_TO_CONSOLE_EVENT, eh_WriteToConsole);
		}
		
		public function Update():void
		{
			checkDurations();
			
			refresh();
		}
		
		private function eh_WriteToConsole(evt:ConsoleEvent):void
		{
			addText(evt.E_Text, evt.E_Duration);
		}
		
		private function addText(text:String, duration:Number):void
		{
			m_ConsoleLines.push(new ConsoleLine("\n"+ text, duration));
		}
		
		private function refresh():void
		{
			m_ConsoleText.text = "";
			
			for each(var consoleLine:ConsoleLine in m_ConsoleLines)
			{
				m_ConsoleText.appendText(consoleLine.Text);
			}
		}
		
		private function checkDurations():void
		{
			for (var index:int = 0; index < m_ConsoleLines.length; index++)
			{
				m_ConsoleLines[index].Update();
				
				if (m_ConsoleLines[index].ShouldRemove)
				{
					m_ConsoleLines.splice(index, 1);
				}
			}
		}
		
		public static function get eventDispatcher():IEventDispatcher
		{
			return g_EventDispatcher;
		}
	}
}