package Utils.ImageContent 
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.display.BitmapData;
	
	public class ImageLoader 
	{	
		private static var images:Dictionary = new Dictionary();
		
		public static function InitializeImage(imageClass:Class, framesX:int = 1, framesY:int = 1):void
		{
			images[imageClass] = new ImageClass(imageClass, framesX, framesY);
		}
		
		public static function GetImage(imageClass:Class):Image
		{	
			var tempImageClass:ImageClass = ImageLoader.images[imageClass];
			
			return new Image(tempImageClass.Source.bitmapData, tempImageClass.FramesX, tempImageClass.FramesY);
		}
	}
}