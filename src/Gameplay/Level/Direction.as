package Gameplay.Level 
{
	/**
	 * ...
	 * @author Evan Schipellite
	 */
	public class Direction 
	{
		public static const NORTH:int = 0;
		public static const SOUTH:int = 1;
		public static const EAST:int = 2;
		public static const WEST:int = 3;
		
		public static function GetOppositeExit(exit:int):int
		{
			switch(exit)
			{
				case NORTH:
					return SOUTH;
					break;
				case SOUTH:
					return NORTH;
					break;
				case EAST:
					return WEST;
					break;
				case WEST:
					return EAST;
					break;
				default:
					return -1;
					break;
			}
		}
	}
}