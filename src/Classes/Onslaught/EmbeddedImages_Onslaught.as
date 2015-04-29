package Classes.Onslaught 
{
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author EvanSchipellite
	 */

	public class EmbeddedImages_Onslaught
	{		
		[Embed(source="../../../content/Images/Classes/Onslaught/Onslaught_Selection.png")]
		public static var Onslaught_Selection:Class;
		
		[Embed(source="../../../content/Images/Classes/Onslaught/Onslaught_Player.png")]
		public static var Onslaught_Player:Class;
		
		[Embed(source="../../../content/Images/Classes/Onslaught/Onslaught_Sword.png")]
		public static var Onslaught_Sword:Class;
		
		[Embed(source="../../../content/Images/Classes/Onslaught/Onslaught_AbilityOne_Attack.png")]
		public static var Onslaught_AbilityOne_Attack:Class;
		
		public static function LoadImages():void
		{
			ImageLoader.InitializeImage(Onslaught_Selection);
			ImageLoader.InitializeImage(Onslaught_Player, 6);
			ImageLoader.InitializeImage(Onslaught_Sword);
			ImageLoader.InitializeImage(Onslaught_AbilityOne_Attack);
		}
	}
}