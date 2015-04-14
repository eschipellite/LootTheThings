package Classes 
{
	import Classes.Brigadier.EmbeddedImages_Brigadier;
	import Classes.Duelist.EmbeddedImages_Duelist;
	import Classes.Earthen.EmbeddedImages_Earthen;
	import Classes.Onslaught.EmbeddedImages_Onslaught;
	import Classes.Onslaught.Onslaught;
	import Classes.Runner.EmbeddedImages_Runner;
	import Classes.Shade.EmbeddedImages_Shade;
	import Gameplay.Player.Player;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	/**
	 * ...
	 * @author ...
	 */
	public class ClassTypes 
	{
		public static const ONSLAUGHT:int = 0;
		public static const BRIGADIER:int = 1;
		public static const RUNNER:int = 2;
		public static const EARTHEN:int = 3;
		public static const DUELIST:int = 4;
		public static const SHADE:int = 5;
		
		public static const TOTAL_CLASS_TYPES:int = 6;
		
		private static const ONSLAUGHT_NAME:String = "Onslaught";
		private static const BRIGADIER_NAME:String = "Brigadier";
		private static const RUNNER_NAME:String = "Runner";
		private static const EARTHEN_NAME:String = "Earthen";
		private static const DUELIST_NAME:String = "Duelist";
		private static const SHADE_NAME:String = "Shade";
		
		private static const ONSLAUGHT_IMAGE_CLASS:Class = EmbeddedImages_Onslaught.Onslaught_Selection;
		private static const BRIGADIER_IMAGE_CLASS:Class = EmbeddedImages_Brigadier.Brigadier_Selection;
		private static const RUNNER_IMAGE_CLASS:Class = EmbeddedImages_Runner.Runner_Selection;
		private static const EARTHEN_IMAGE_CLASS:Class = EmbeddedImages_Earthen.Earthen_Selection;
		private static const DUELIST_IMAGE_CLASS:Class = EmbeddedImages_Duelist.Duelist_Selection;
		private static const SHADE_IMAGE_CLASS:Class = EmbeddedImages_Shade.Shade_Selection;
		
		public static function GetClassName(classType:int):String
		{
			switch(classType)
			{
				case ONSLAUGHT:
					return ONSLAUGHT_NAME;
					break;
				case BRIGADIER:
					return BRIGADIER_NAME;
					break;
				case RUNNER:
					return RUNNER_NAME;
					break;
				case EARTHEN:
					return EARTHEN_NAME;
					break;
				case DUELIST:
					return DUELIST_NAME;
					break;
				case SHADE:
					return SHADE_NAME;
					break;
				default:
					return "NULL";
			}
		}
		
		public static function GetClassImage(classType:int):Image
		{
			switch(classType)
			{
				case ONSLAUGHT:
					return ImageLoader.GetImage(ONSLAUGHT_IMAGE_CLASS);
					break;
				case BRIGADIER:
					return ImageLoader.GetImage(BRIGADIER_IMAGE_CLASS);
					break;
				case RUNNER:
					return ImageLoader.GetImage(RUNNER_IMAGE_CLASS);
					break;
				case EARTHEN:
					return ImageLoader.GetImage(EARTHEN_IMAGE_CLASS);
					break;
				case DUELIST:
					return ImageLoader.GetImage(DUELIST_IMAGE_CLASS);
					break;
				case SHADE:
					return ImageLoader.GetImage(SHADE_IMAGE_CLASS);
					break;
				default:
					return null;
			}
		}
		
		public static function GetClassInstance(classType:int):Player
		{
			switch(classType)
			{
				case ONSLAUGHT:
					return new Onslaught();
					break;
				case BRIGADIER:
					return new Onslaught();
					break;
				case RUNNER:
					return new Onslaught();
					break;
				case EARTHEN:
					return new Onslaught();
					break;
				case DUELIST:
					return new Onslaught();
					break;
				case SHADE:
					return new Onslaught();
					break;
				default:
					return null;
			}
		}
	}
}