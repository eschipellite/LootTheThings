package Menu.Main.Buttons 
{
	import flash.desktop.NativeApplication;
	import flash.display.NativeWindow;
	import flash.system.Capabilities;
	import flash.system.fscommand;
	import Menu.Main.EmbeddedImages_Main;
	import Utils.Output.Console;
	/**
	 * ...
	 * @author ...
	 */
	public class ExitButton extends MenuButton
	{
		public function ExitButton() 
		{
			m_ImageClass = EmbeddedImages_Main.Main_Exit;
		}
		
		override public function DoAction():void
		{
			if (Main.IsOnConsole)
			{
				NativeApplication.nativeApplication.exit();
			}
			else
			{
				if (Capabilities.playerType == 'Desktop')
				{
					NativeApplication.nativeApplication.exit();
				}
				else
				{
					fscommand("quit");
				}
			}
		}
	}
}