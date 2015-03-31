package Utils 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import Utils.ImageContent.Image;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class UtilMethods 
	{
		public static const FLOOR:String = "floor";
		public static const CEIL:String = "ceil";
		public static const ROUND:String = "round";
		
		private static function RandomRange(min:Number, max:Number = 0):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		public static function Random(minValue:Number, maxValue:Number, params:String = ""):Number
		{
			if (params == FLOOR)
			{
				return Math.floor(RandomRange(minValue, maxValue));
			}
			else if (params == CEIL)
			{
				return Math.ceil(RandomRange(minValue, maxValue));
			}
			else if (params == ROUND)
			{
				return Math.round(RandomRange(minValue, maxValue));
			}
			else
				return RandomRange(minValue, maxValue);
		}
		
		public static function LerpToPoint(start:Point, end:Point, lerpAmount:Number):Point
		{
			var lerpPoint:Point = new Point(0, 0);
			
			lerpPoint.x = (1 - lerpAmount) * start.x + lerpAmount * end.x;
			lerpPoint.y = (1 - lerpAmount) * start.y + lerpAmount * end.y;
			
			return lerpPoint;
		}
		
		public static function Lerp(start:Number, end:Number, lerpAmount:Number):Number
		{
			return ((1 - lerpAmount) * start + lerpAmount * end);
		}
		
		public static function Clone(object:Object):*
		{
			var byteArray:ByteArray = new ByteArray();
			
			byteArray.writeObject(object);
			
			byteArray.position = 0;
			
			return(byteArray.readObject());
		}
		
		public static function StringToPoint(string:String):Point
		{			
			var tempArray:Array = string.split(" ");
			
			if (tempArray.length >= 2)
			{
				return new Point(int(tempArray[0]), int(tempArray[1]));
			}
			
			return new Point(0, 0);
		}
		
		public static function StringToRectangle(string:String):Rectangle
		{			
			var tempArray:Array = string.split(" ");
			
			if (tempArray.length >= 4)
			{
				return new Rectangle(int(tempArray[0]), int(tempArray[1]), int(tempArray[2]), int(tempArray[3]));
			}
			
			return new Rectangle();
		}
		
		public static function XMLNewLine(string:String):String
		{
			var tempString:String = string.split("\\n").join("\n");
			
			return tempString;
		}
		
		public static function StringTo2DArray(string:String):Array
		{
			var rows:Array = string.split("\n\t\t");
			
			var array:Array = new Array();
			
			for (var row:int = 0; row < rows.length; row++)
			{
				array[row] = StringToArray(rows[row]);
				
				for (var col:int = 0; col < array[row].length; col++)
				{
					array[row][col] = int(array[row][col]);
				}
			}
			
			return array;
		}
		
		public static function StringToArray(string:String):Array
		{
			return string.split(" ");
		}
		
		//http://www.milkisevil.com/blog/2010/as3-vector-shuffle-randomize/
		private static function swap(vect:Object, a:uint, b:uint):void
		{
			var temp : Object = vect[a];
			vect[a] = vect[b];
			vect[b] = temp;
		}
		
		//http://www.milkisevil.com/blog/2010/as3-vector-shuffle-randomize/
		public static function ShuffleVector(vector:Object):void
		{
			var totalItems : uint = vector.length;
			for (var i : uint = 0; i < totalItems; i++)
			{
				swap( vector, i, i + uint( Math.random() * (totalItems - i) ) );
			}
		}
		
		public static function GetClass(object:Object):Class 
		{
			return Class(getDefinitionByName(getQualifiedClassName(object)));
		}
		
		public static function VectorToDegreeRotation(vector:Point):Number
		{
			return (int)(Math.atan2(vector.y, vector.x) / (Math.PI) * 180);
		}
	}
}