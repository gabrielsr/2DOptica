package br.com.animisica.ondulatoria
{
	import flash.geom.Point;

	public class SuperficieOndCircular extends SuperfOnd
	{
			
		/*
		* Classe que representa uma superfície curva
		*/
		
		public var pCentro:Point;
		public var raio:Number;
		public var angIni:Number;
		public var angAbertura:Number;
		
		
		public function SuperficieOndCircular(pCentro:Point, raio:Number, angIni:Number, angAbertura:Number)
		{
			this.pCentro = pCentro;
			this.raio = raio;
			this.angIni = angIni;
			this.angAbertura = angAbertura;			
		}

		public override function testaEncontro(onda:Onda):Encontro
		{
			/* Solução usa equanções paramétricas, e um sitema linear por matrizes
			*/
			
			//trace("testando encontro superficie circular");
			var a:Number = onda.sinAng*onda.sinAng + onda.cosAng*onda.cosAng;
			var b:Number = 2*(onda.cosAng*(onda.pos.x - pCentro.x) + onda.sinAng*(onda.pos.y - pCentro.y));
			var c:Number = Math.pow(onda.pos.x - pCentro.x,2) + Math.pow(onda.pos.y - pCentro.y,2) - raio*raio;
			var delta:Number = b*b -4*a*c;
			//trace("delta: ", delta);
			if(delta <= 0) // não tem nenhuma ou apenas uma solução real. Ou o cario não cruza a superfície ou apenas tangencia
			{
				if(onda.geracao==1)
					//trace("delta:",delta);
				return null;
			}				
			//else ...
			var t1:Number;
			var pEncontro1:Point = new Point();
			var angEncontro1:Number;
			var distancia1:Number = Number.POSITIVE_INFINITY;

			var t2:Number;
			var pEncontro2:Point = new Point();
			var angEncontro2:Number;
			var distancia2:Number = Number.POSITIVE_INFINITY;
			var angNormal1:Number;
			var angNormal2:Number;

			//calcula os dados para os dois possíveis pontos de encontro
			
			//primeiro ponto, primeira soluação da equação
			t1 = (-1*b+Math.sqrt(delta))/2*a;
			//trace("t1",t1);
			if(t1 >0) //t só é válido se maior que 0, pois o raio só se propaga para frente
			{
				pEncontro1.x = onda.cosAng*t1 + onda.pos.x;
				pEncontro1.y = onda.sinAng*t1 + onda.pos.y;
				//
				angEncontro1 = MathAux.toPositiveAng(MathAux.coefToAng(pEncontro1.x - pCentro.x, pEncontro1.y - pCentro.y));
				
									
				if( (angAbertura>0) && (MathAux.toPositiveAng(angEncontro1 - angIni) < angAbertura))
				{
					angNormal1 = angEncontro1;
					distancia1 = Point.distance(pEncontro1,onda.pos);
				}
				else if( (angAbertura<0) && (MathAux.toPositiveAng(angEncontro1 - angIni)-2*Math.PI > angAbertura) )
				{
					angNormal1 = MathAux.toPositiveAng(angEncontro1 - Math.PI);
					distancia1 = Point.distance(pEncontro1,onda.pos);			
				}
			}
			
			//segundo ponto, segunda soluação da equação
			t2 = (-1*b-Math.sqrt(delta))/2*a;
			//trace("t2",t2);
			if(t2 >0) //t só é válido se maior que 0, pois o raio só se propaga para frente
			{
				pEncontro2.x = onda.cosAng*t2 + onda.pos.x;
				pEncontro2.y = onda.sinAng*t2 + onda.pos.y;

				//
				angEncontro2 = MathAux.toPositiveAng(MathAux.coefToAng(pEncontro2.x - pCentro.x, pEncontro2.y - pCentro.y));

					
				if( (angAbertura>0) && (MathAux.toPositiveAng(angEncontro2 - angIni) < angAbertura))
				{
					angNormal2 = angEncontro2;
					distancia2 = Point.distance(pEncontro2,onda.pos);
				}
				else if( (angAbertura<0) && (MathAux.toPositiveAng(angEncontro2 - angIni)-2*Math.PI > angAbertura) )
				{
					angNormal2 = MathAux.toPositiveAng(angEncontro2 - Math.PI);
					distancia2 = Point.distance(pEncontro2,onda.pos);
				}
					
			}
				
			//verifica qual solução está mais próxima
			
			if(distancia1==distancia2) //as duas são positive_infinitive ainda, não existe ponto de encontro valido
			{
				//if(onda.geracao==1)
					//trace("distancias iguais");
				return null;
			}
			else if(distancia1<distancia2)
			{
				//if(onda.geracao==1)
					//trace("encontro1");
				//GraphAux.printLine(pEncontro1, angNormal1);
				return new Encontro(pEncontro1,angNormal1,onda);
			}
			else
			{
				//if(onda.geracao==1)
					//trace("encontro2");
				//GraphAux.printLine(pEncontro2, angNormal2);
				return new Encontro(pEncontro2,angNormal2,onda);
			}

		}
		
	}
}