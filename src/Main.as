package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import General.Embedded_Content.EmbeddedImages_General;
	import General.Embedded_Content.EmbeddedSounds_General;
	import General.LocalData.LocalData;
	import General.States.StateHandler;
	import General.Statistics.StatisticsHandler;
	import Utils.FPS;
	import Utils.GameTime;
	import Utils.InputContent.Input;
	import Utils.InputContent.Mouse;
	
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class Main extends Sprite
	{		
		private var m_FPS:FPS;
		
		private var m_StateHandler:StateHandler;
		
		private static var m_Stage:Stage;
		
		public function Main():void 
		{	
			m_Stage = stage;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			GameTime.InitializeGameTime();
			m_FPS = new FPS();
			
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
			
			m_StateHandler.Initialize();
			
			initializeEventListeners();
			
			this.addChild(m_StateHandler);
			
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
			
			stage.addEventListener(Event.ENTER_FRAME, update);
			
			m_StateHandler.InitializeEventListeners();
			
			StatisticsHandler.InitializeEventListeners();
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
			
			LocalData.Update();
		}
		
		public static function get StageSize():Point
		{
			return new Point(m_Stage.stageWidth, m_Stage.stageHeight);
		}
	}
}