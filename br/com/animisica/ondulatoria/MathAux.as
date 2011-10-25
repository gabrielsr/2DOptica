package br.com.animisica.ondulatoria
{
	import flash.geom.Point;
	public class MathAux
	{
		
		public static function normAng(ang:Number):Number
		{
				while (ang>Math.PI)
				{
					ang -= 2*Math.PI;
					//trace("norm:"+ang);
				}
				while(ang<=(-1*Math.PI) )
				{
					ang += 2*Math.PI;
					//trace("norm:"+ang);
				}
				
				return ang;
	
		}
		public static function toPositiveAng(ang:Number):Number
		{
				while (ang>2*Math.PI)
				{
					ang -= 2*Math.PI;
					//trace("norm:"+ang);
				}
				while(ang<0)
				{
					ang += 2*Math.PI;
					//trace("norm:"+ang);
				}
				
				return ang;
			
		}
											 
		// recebe os coeficientes das equações paramétricas e retorna o angulo com a horizontal.
		public static function coefToAng(ax:Number, ay:Number):Number
		{
			var ro:Number = Math.sqrt(ax*ax + ay*ay);
			ax = ax/ro;
			ay = ay/ro;
			
			if(ay<0)
				return (-1*Math.acos(ax));
			else
				return (Math.acos(ax));

		}
		public static function translada(px:Number, py:Number, rx:Number, ry:Number, rotAng:Number):Point
		{
			var newPoint:Point = new Point();
			var ax:Number = px;
			var ay:Number = py;
			var iniAng:Number;


			var ro:Number = Math.sqrt(ax*ax + ay*ay);
			if(ro==0)
			{
				return new Point(rx,ry);
			}
			ax = ax/ro;
			ay = ay/ro;
			
			if(ay<0)
				iniAng = -1*Math.acos(ax);
			else
				iniAng = Math.acos(ax);

			
			newPoint.x = Math.cos(iniAng+rotAng)*ro + rx;
			newPoint.y = Math.sin(iniAng+rotAng)*ro + ry;
			
			return newPoint;
		}
	}
	
}