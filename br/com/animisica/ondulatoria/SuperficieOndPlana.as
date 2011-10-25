package br.com.animisica.ondulatoria
{
	import flash.geom.Point;

	public class SuperficieOndPlana extends SuperfOnd
	{
			
		/*
		* Classe que representa uma superfície plana
		*/
		//dois pontos que definem a superficie plana
		public var pR1:Point;
		public var pR2:Point;
				
		//variáveis usadas na busca pelo encontro do raio, précalculadas para agilizar o processo.
		private var dx21:Number;
		private var dy21:Number;
		
		//coeficientes das retas paramétricas das quais o segmento de reta pertence
		private var ax:Number;
		private var ay:Number;
		
		//angulo da retaNormal
		private var angNorm:Number;
		
		
		//coeficiente angular da reta que representa a superficie
		public var a:Number;
		
		public function SuperficieOndPlana(pR1:Point, pR2:Point)
		{
			this.pR1 = pR1;
			this.pR2 = pR2;
			atualizarSuperficie();			
			
		}
		public override function atualizarSuperficie()
		{
			this.dx21= pR2.x - pR1.x;
			this.dy21 = pR2.y - pR1.y;
			var ro:Number = Math.sqrt((dy21)*(dy21) + (dx21)*(dx21));
			this.ax = dx21/ro;
			this.ay = dy21/ro;

			//achando o angulo da reta normal
			angNorm = MathAux.coefToAng(ay,-1*ax);
		}

		public override function testaEncontro(onda:Onda):Encontro
		{
			/* Solução usa equanções paramétricas, e um sitema linear por matrizes
			*/
			var det:Number = onda.sinAng*dx21-onda.cosAng*dy21; //determinante 
			var t1:Number = ( (onda.pos.x - pR1.x)*dy21 + dx21*(pR1.y - onda.pos.y) )/det;
			var t2:Number = ( onda.cosAng*(pR1.y-onda.pos.y) - onda.sinAng*(pR1.x-onda.pos.x) )/det;
			//trace("t2:"+t2+", t1:"+t1+", det:"+det);			
			if( t1<=0||t2>1||t2<0)
			{
				return null;				
			}
			else 
			{
				var pontoEnc:Point = new Point(pR1.x + dx21*t2,pR1.y + dy21*t2);
				//GraphAux.printLine(pontoEnc, angNorm);
				return new Encontro(pontoEnc,angNorm,onda);
			}
		}
		public override function angRetaNormal(onda:Onda, ponto:Point):Number
		{
			return angNorm;
		}

	}
}