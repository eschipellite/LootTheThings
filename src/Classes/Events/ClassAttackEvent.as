package Classes.Events 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import Gameplay.Level.Room;
	import Gameplay.Level.Waves.Wave;
	import Gameplay.Level.Waves.WaveInfo;
	import Gameplay.Player.Player;
	import Utils.ImageContent.Image;
	
	public class ClassAttackEvent extends Event
	{
		public static const CLASS_ATTACK_EVENT:String = "CLASS_ATTACK_EVENT";
		
		public var E_Attack:Rectangle;
		
		public var E_Player:Player;
		
		public function ClassAttackEvent(type:String, attack:Rectangle, player:Player) 
		{
			super(type, false, false);
			
			E_Attack = attack;
			E_Player = player;
		}	
	}
}