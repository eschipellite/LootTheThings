package Gameplay.Player 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Player
	{
		[Embed(source="../../../content/Images/Gameplay/Player/Player.png")]
		public static var Player_Player:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Player_Player, 4);
		}
	}
}