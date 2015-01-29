package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.GameInputEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.ui.GameInput;
	import General.Embedded_Content.EmbeddedImages_General;
	import General.Embedded_Content.EmbeddedSounds_General;
	import General.LocalData.LocalData;
	import General.States.StateHandler;
	import General.Statistics.StatisticsHandler;
	import Utils.FPS;
	import Utils.GameTime;
	import Utils.InputContent.Controllers.Input_GameController;
	import Utils.InputContent.Input;
	import Utils.InputContent.Mouse;
	import Utils.Output.Console;
	import Utils.Output.Events.ConsoleEvent;
	
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class Main extends Sprite
	{		
		private static var m_Stage:Stage;
		
		private var m_FPS:FPS;
		
		private var m_StateHandler:StateHandler;
		
		private var m_Console:Console;
		
		private var m_GameInput:GameInput;
		
		private static var m_Inset:Point = new Point(0, 0);
		
		private static var m_SafeArea:Point = new Point(0, 0);
		
		public function Main():void 
		{	
			m_Stage = stage;
			
			stage.scaleMode = StageScaleMode.NO_BORDER;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageWidth = Capabilities.screenResolutionX;
			stage.stageHeight = Capabilities.screenResolutionY;
			m_SafeArea.x = stage.stageWidth;
			m_SafeArea.y = stage.stageHeight;
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.addEventListener(Event.RESIZE, eh_Resize);
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			GameTime.InitializeGameTime();
			m_FPS = new FPS();
			m_Console = new Console();
			m_GameInput = new GameInput();
			
			LocalData.SetClassAliases();
			
			m_StateHandler = new StateHandler();
			
			StatisticsHandler.CreateStatistics();
			
			initialize();
			
			LocalData.Load();
			
			startGame();
		}
		
		private function deactivate(e:Event):void 
		{
			LocalData.Save();
			
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
		private function initialize():void
		{
			EmbeddedImages_General.LoadImages();
			EmbeddedSounds_General.LoadSounds();
			
			m_Console.Initialize();
			m_StateHandler.Initialize();
			
			initializeEventListeners();
			
			this.addChild(m_StateHandler);
			
			this.addChild(m_Console);
			
			this.addChild(m_FPS);
		}
		
		private function initializeEventListeners():void
		{	
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
			stage.addEventListener(Event.ENTER_FRAME, mousePositionListener);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelListener);
			
			m_GameInput.addEventListener(GameInputEvent.DEVICE_ADDED, eh_AddController);
			m_GameInput.addEventListener(GameInputEvent.DEVICE_REMOVED, eh_RemoveController);
			
			stage.addEventListener(Event.ENTER_FRAME, update);
			
			m_Console.InitializeEventListeners();
			m_StateHandler.InitializeEventListeners();
			
			StatisticsHandler.InitializeEventListeners();
		}
		
		private function eh_Resize(evt:Event):void
		{
			if ((Capabilities.screenResolutionX == stage.stageWidth) && (Capabilities.screenResolutionY == stage.stageHeight)) 
			{
				m_Inset.x = .075 * Capabilities.screenResolutionX;
				m_Inset.y = .075 * Capabilities.screenResolutionY;
				m_SafeArea.x = Capabilities.screenResolutionX - (2 * m_Inset.x);
				m_SafeArea.y = Capabilities.screenResolutionY - (2 * m_Inset.y);
			}
		}
		
		private function keyDownListener(e:KeyboardEvent):void
		{
			Input.KeyDownListener(e);
		}
		
		private function keyUpListener(e:KeyboardEvent):void
		{
			Input.KeyUpListener(e);
		}
		
		private function mouseDownListener(e:MouseEvent):void
		{
			Input.SetMouse(Mouse.DOWN);
		}
		
		private function mouseUpListener(e:MouseEvent):void
		{
			Input.SetMouse(Mouse.UP);
		}
		
		private function mousePositionListener(e:Event):void
		{
			Input.SetMousePosition(new Point(stage.mouseX, stage.mouseY));
		}
		
		private function mouseWheelListener(e:MouseEvent):void
		{
			Input.UpdateMouseWheel(e.delta);
		}
		
		private function eh_AddController(evt:GameInputEvent):void
		{
			Input_GameController.AddController(evt.device);
		}
		
		private function eh_RemoveController(evt:GameInputEvent):void
		{
			Input_GameController.RemoveController(evt.device);
		}
		
		private function startGame():void
		{
			CONFIG::debug
			{
				m_FPS.Start();
			}
			
			m_StateHandler.StartGame();
		}
		
		private function update(e:Event):void
		{
			GameTime.Update();
			
			m_StateHandler.Update();
			
			Input.Update();
			
			Input_GameController.Update();
			
			m_Console.Update();
			
			LocalData.Update();
			
			Console.eventDispatcher.dispatchEvent(new ConsoleEvent(ConsoleEvent.WRITE_TO_CONSOLE_EVENT, "Hello, how are you doing? Is this enough screen space? Blah Blah Blah Blah Blah Blah Hello, how are you doing? Is this enouth r?"));
		}
		
		public static function get StageSize():Point
		{
			return new Point(m_Stage.stageWidth, m_Stage.stageHeight);
		}
	}
}