package Menu.PlayerSelection 
{
	import Classes.ClassTypes;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class ClassSelection extends Sprite
	{
		private var m_Image:Image;
		
		private var m_ClassType:int;
		
		private var m_ClassNameTextField:TextField;
		private var m_ClassNameTextField_FontSize:int = 32;
		private var m_ClassNameTextField_Size:Point = new Point(256, 48);
		private var m_ClassNameTextField_Position:Point = new Point(0, -48);
		private var m_ClassNameTextField_Color:uint = 0x000000;
		private var m_ClassName:String;
		
		public function ClassSelection() 
		{	
			m_ClassNameTextField = new TextField();
		}
		
		public function Initialize(classType:int):void
		{
			m_ClassType = classType;
			
			m_Image = ClassTypes.GetClassImage(m_ClassType);
			
			m_ClassName = ClassTypes.GetClassName(m_ClassType);
			
			createClassNameTextField();
			
			this.addChild(m_Image);
			this.addChild(m_ClassNameTextField);
		}
		
		private function createClassNameTextField():void
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = m_ClassNameTextField_FontSize;
			textFormat.color = m_ClassNameTextField_Color;
			textFormat.align = TextFormatAlign.CENTER;
			
			m_ClassNameTextField.defaultTextFormat = textFormat;
			m_ClassNameTextField.width = m_ClassNameTextField_Size.x;
			m_ClassNameTextField.height = m_ClassNameTextField_Size.y
			m_ClassNameTextField.wordWrap = true;
			m_ClassNameTextField.selectable = false;
			m_ClassNameTextField.x = m_ClassNameTextField_Position.x;
			m_ClassNameTextField.y = m_ClassNameTextField_Position.y;
			m_ClassNameTextField.text = m_ClassName;
		}
		
		public function get ClassType():int
		{
			return m_ClassType;
		}
	}
}