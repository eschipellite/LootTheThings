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
	import flash.ui.Keyboard;
	import General.Embedded_Content.EmbeddedImages_General;
	import General.Embedded_Content.EmbeddedSounds_General;
	import General.LocalData.LocalData;
	import General.States.StateHandler;
	import General.Statistics.StatisticsHandler;
	import Utils.FPS;
	import Utils.GameTime;
	import Utils.InputContent.Controllers.ControllerInput;
	import Utils.InputContent.Input;
	import Utils.InputContent.Mouse;
	import Utils.Output.Console;
	import flash.system.fscommand;
	
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
		
		private static var ms_Inset:Point;
		private static var ms_ScreenArea:Point;
		
		private var m_InsetRatio:Number = .075;
		
		public function Main():void 
		{	
			m_Stage = stage;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			CONFIG::release
			{
				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			
			stage.addEventListener(Event.RESIZE, eh_Resize);
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			stage.addEventListener(Event.FULLSCREEN, eh_FullScreen);
			
			eh_Resize(null);
			
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
			
			ControllerInput.Initialize();
			
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
			
			m_StateHandler.InitializeEventListeners();
			
			StatisticsHandler.InitializeEventListeners();
		}
		
		private function eh_Resize(evt:Event):void
		{
			ms_Inset = new Point(0, 0);
			
			CONFIG::debug
			{
				ms_ScreenArea = new Point(stage.stageWidth, stage.stageHeight);
			}
			
			CONFIG::release
			{
				ms_ScreenArea = new Point(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			}
			
			ms_Inset.x = m_InsetRatio * ms_ScreenArea.x;
			ms_Inset.y = m_InsetRatio * ms_ScreenArea.y;
		}
		
		private function eh_FullScreen(evt:Event):void
		{
			if (stage.displayState != StageDisplayState.FULL_SCREEN)
			{
				fscommand("quit");
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
			ControllerInput.AddController(evt.device);
		}
		
		private function eh_RemoveController(evt:GameInputEvent):void
		{
			ControllerInput.RemoveController(evt.device);
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
			
			m_Console.Update();
			
			LocalData.Update();
			
			if (Input.Pressed(Keyboard.ESCAPE))
			{
				fscommand("quit");
			}
			
			Input.Update();
			
			ControllerInput.Update();
		}
		
		public static function get Inset():Point
		{
			return new Point(ms_Inset.x, ms_Inset.y);
		}
		
		public static function get ScreenArea():Point
		{
			return new Point(ms_ScreenArea.x, ms_ScreenArea.y);
		}
	}
}