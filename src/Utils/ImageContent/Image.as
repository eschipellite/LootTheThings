package Utils.ImageContent 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Utils.UtilMethods;
	
	public class Image extends Bitmap
	{
		private var m_MaxFrames:Point;
		private var m_TotalFrames:int;
		
		private var m_CurrentFrame:Point;
		
		private var m_FrameSize:Point;
		private var m_Origin:Point;
		
		public function Image(bitmapData:BitmapData = null, framesX:int = 1, framesY:int = 1, pixelSnapping:String = "always", smoothing:Boolean = false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			
			m_MaxFrames = new Point(framesX, framesY);
			m_TotalFrames = m_MaxFrames.x * m_MaxFrames.y;
			
			m_CurrentFrame = new Point(0, 0);
			
			m_FrameSize = new Point(this.width / m_MaxFrames.x, this.height / m_MaxFrames.y);
			m_Origin = new Point(m_FrameSize.x / 2, m_FrameSize.y / 2);
			
			refresh();
		}
		
		private function setFrame(frame:int):void
		{			
			var row:int = Math.floor(frame / m_MaxFrames.x);
			var col:int = frame % m_MaxFrames.x;
			
			m_CurrentFrame.x = col;
			m_CurrentFrame.y = row;
		}
		
		private function refresh():void
		{
			this.scrollRect = new Rectangle(m_CurrentFrame.x * m_FrameSize.x, m_CurrentFrame.y * m_FrameSize.y, m_FrameSize.x, m_FrameSize.y);
		}
		
		public function get Frame():int
		{	
			return int(m_MaxFrames.x * m_CurrentFrame.y + m_CurrentFrame.x);
		}
		
		public function set Frame(frame:int):void
		{
			if (frame < 0)
			{
				while (frame < 0)
				{
					frame += m_TotalFrames;
				}
			}
			
			if (frame >= m_TotalFrames)
			{
				while (frame >= m_TotalFrames)
				{
					frame -= m_TotalFrames;
				}
			}
			
			if (frame >= 0)
			{
				setFrame(frame);
			
				refresh();
			}
		}
		
		public function get TotalFrames():int
		{
			return m_TotalFrames;
		}
		
		public function set TotalFrames(frames:int):void
		{
			m_TotalFrames = frames;
		}
		
		public function set Rotation(degrees:Number):void
		{
			UtilMethods.Rotation(this, degrees, this.Origin);
		}
		
		public function SetOrigin(origin:Point):void
		{
			m_Origin = origin;
		}
		
		public function CollisionWithPoint(point:Point):Boolean
		{
			return this.CollisionBounds.containsPoint(point);
		}
		
		public function CollisionPixelPerfect(point:Point):Boolean
		{
			if (this.CollisionWithPoint(point))
			{
				var bitmapFrame:BitmapData = this.FrameBitmapData;
				
				var m:Matrix = new Matrix();
				m.scale(this.scaleX, this.scaleY);
				
				bitmapFrame.draw(bitmapFrame, m);
				
				return bitmapFrame.hitTest(new Point(this.x, this.y), 1, point);
			}
			
			return false;
		}
		
		public function get FrameWidth():int
		{
			return m_FrameSize.x * this.scaleX;
		}
		
		public function get FrameHeight():int
		{
			return m_FrameSize.y * this.scaleY;
		}
		
		public function get Origin():Point
		{
			return m_Origin;
		}
		
		public function get CollisionBounds():Rectangle
		{			
			return new Rectangle(this.x, this.y, this.FrameWidth * this.scaleX, this.FrameHeight * this.scaleY);
		}
		
		public function get FrameRect():Rectangle
		{
			return new Rectangle(m_CurrentFrame.x * m_FrameSize.x, m_CurrentFrame.y * m_FrameSize.y, m_FrameSize.x, m_FrameSize.y);
		}
		
		public function get FrameBitmapData():BitmapData
		{
			var bitmapFrame:BitmapData = new BitmapData(this.FrameWidth, this.FrameHeight);
				
			bitmapFrame.copyPixels(this.bitmapData, this.FrameRect, new Point());
			
			return bitmapFrame;
		}
		
		public function SetFrameRowAndCol(row:int, col:int):void
		{
			m_CurrentFrame.x = row;
			m_CurrentFrame.y = col;
			
			refresh();
		}
	}
}