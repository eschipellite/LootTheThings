package Classes.Onslaught 
{
	import Classes.Events.ClassAttackEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Gameplay.EmbeddedImages_Gameplay;
	import Gameplay.Player.ActionState;
	import Gameplay.Player.Player;
	import Gameplay.State_Gameplay;
	import General.Camera;
	import Utils.GameTime;
	import Utils.ImageContent.Image;
	import Utils.ImageContent.ImageLoader;
	import Utils.InputContent.Controllers.ControllerInput;
	import Utils.InputContent.Controllers.GameController;
	import Utils.UtilMethods;
	/**
	 * ...
	 * @author ...
	 */
	public class Onslaught extends Player
	{
		private var m_AbilityOne_StartFrame:int = 1;
		private var m_AbilityOne_EndFrame:int = 5;
		private var m_AbilityOne_AnimationTime:Number = .1;
		private var m_AbilityOne_CurrentAnimationTime:Number = 0;
		private var m_AbilityOne_Attack:Image;
		private var m_AbilityOne_Attack_Offset:Point = new Point(48, 0);
		
		public function Onslaught() 
		{
		}
		
		override public function Initialize(index:int):void 
		{
			super.Initialize(index);
		}
		
		protected override function loadImages():void
		{
			m_PlayerBase.Initialize(EmbeddedImages_Onslaught.Onslaught_Player, m_PlayerSize);
			m_AbilityOne_Attack = ImageLoader.GetImage(EmbeddedImages_Onslaught.Onslaught_AbilityOne_Attack);
			m_AbilityOne_Attack.x += m_AbilityOne_Attack_Offset.x;
			m_AbilityOne_Attack.y = m_AbilityOne_Attack_Offset.y;
			m_AbilityOne_Attack.visible = false;
			m_PlayerBase.addChild(m_AbilityOne_Attack);
		}
		
		public override function Update():void
		{
			super.Update();
		}
		
		protected override function checkRotationInput():void
		{
			super.checkRotationInput();
		}
		
		protected override function checkRightTrigger():void
		{
			if (m_ActionState == ActionState.IDLE && ControllerInput.GetController(m_Index).ButtonPressed(GameController.RIGHT_TRIGGER))
			{
				m_ActionState = ActionState.ABILITY_ONE;
				m_AbilityOne_CurrentAnimationTime = 0;
				m_PlayerBase.SetBaseFrame(m_AbilityOne_StartFrame);
			}
		}
		
		protected override function updateAbilityOne():void
		{
			updateAbilityOneAnimation();
			updateAbilityOneDamage();
		}
		
		private function updateAbilityOneAnimation():void
		{
			m_AbilityOne_CurrentAnimationTime += GameTime.ElapsedGameTimeSeconds;
			if (m_AbilityOne_CurrentAnimationTime >= m_AbilityOne_AnimationTime)
			{
				m_AbilityOne_CurrentAnimationTime = 0;
				
				if (m_PlayerBase.BaseFrame != m_AbilityOne_EndFrame)
				{
					m_PlayerBase.IncrementBaseFrame();
				}
				else
				{
					m_ActionState = ActionState.IDLE;
					m_PlayerBase.SetBaseFrame(0);
				}
			}
		}
		
		private function updateAbilityOneDamage():void
		{
			State_Gameplay.eventDispatcher.dispatchEvent(new ClassAttackEvent(ClassAttackEvent.CLASS_ATTACK_EVENT, AbilityOneAttack, this));
		}
		
		public function get AbilityOneAttack():Rectangle
		{
			var position:Point = new Point(m_AbilityOne_Attack.x, m_AbilityOne_Attack.y);
			position = m_AbilityOne_Attack.localToGlobal(position);
			position = Camera.ConvertToCameraPoint(position);
			return new Rectangle(position.x, position.y, m_AbilityOne_Attack.FrameWidth, m_AbilityOne_Attack.FrameHeight);
		}
	}
}