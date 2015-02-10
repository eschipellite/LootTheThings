package Menu 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import Menu.Main.Buttons.ExitButton;
	import Menu.Main.Buttons.MenuButton;
	import Menu.Main.Buttons.OptionsButton;
	import Menu.Main.Buttons.PlayButton;
	import Utils.InputContent.Controllers.ControllerInput;
	import Utils.InputContent.Controllers.GameController;
	import Utils.Output.Console;
	/**
	 * ...
	 * @author ...
	 */
	public class MenuScroller extends Sprite
	{
		private var m_Buttons:Vector.<MenuButton>;
		
		private var m_InitialPosition:Point = new Point(384, 224);
		private var m_Offset:Point = new Point(0, 160);
		
		private var m_SelectedIndex:int;
		
		public function MenuScroller() 
		{
			m_Buttons = new Vector.<MenuButton>();
			
			m_SelectedIndex = 0;
		}
		
		public function Initialize(buttons:Vector.<MenuButton>):void
		{
			for each(var button:MenuButton in buttons)
			{
				m_Buttons.push(button);
			}
			
			createButtons();
			
			selectButton();
		}
		
		private function createButtons():void
		{
			var position:Point = new Point(m_InitialPosition.x, m_InitialPosition.y);
			var offset:Point = new Point(m_Offset.x, m_Offset.y);
			for each(var button:MenuButton in m_Buttons)
			{
				button.Initialize();
				button.SetPosition(position);
				position = new Point(m_InitialPosition.x + offset.x, m_InitialPosition.y + offset.y);
				offset.x += m_Offset.x;
				offset.y += m_Offset.y;
				
				this.addChild(button);
			}
		}
		
		public function Update():void
		{
			checkScroll();
			
			checkAction();
			
			for each(var button:MenuButton in m_Buttons)
			{
				button.Update();
			}
		}
		
		public function Reset():void
		{
			for each(var button:MenuButton in m_Buttons)
			{
				button.Reset();
			}
			
			m_SelectedIndex = 0;
			
			selectButton();
		}
		
		private function selectButton():void
		{
			m_Buttons[m_SelectedIndex].SetSelected(true);
		}
		
		private function checkScroll():void
		{
			var gameControllers:Vector.<GameController> = ControllerInput.GetAllControllers();
			
			for each(var gameController:GameController in gameControllers)
			{
				if (gameController.ButtonPressed(GameController.LEFT_STICK_DOWN))
				{
					scroll( -1);
				}
				else if (gameController.ButtonPressed(GameController.LEFT_STICK_UP))
				{
					scroll(1);
				}
			}
		}
		
		private function scroll(direction:int = 0):void
		{
			m_Buttons[m_SelectedIndex].SetSelected(false);
			m_SelectedIndex += direction;
			
			if (m_SelectedIndex >= m_Buttons.length)
			{
				m_SelectedIndex = 0;
			}
			
			if (m_SelectedIndex < 0)
			{
				m_SelectedIndex = m_Buttons.length - 1;
			}
			
			m_Buttons[m_SelectedIndex].SetSelected(true);
		}
		
		private function checkAction():void
		{
			var gameControllers:Vector.<GameController> = ControllerInput.GetAllControllers();
			
			for each(var gameController:GameController in gameControllers)
			{
				if (gameController.ButtonPressed(GameController.BUTTON_A))
				{
					m_Buttons[m_SelectedIndex].DoAction();
					break;
				}
			}
		}
	}

}