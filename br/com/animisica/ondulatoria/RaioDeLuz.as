package br.com.animisica.ondulatoria
{
	import flash.geom.Point;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import br.com.animisica.ondulatoria.*;
	
	/*
	* Classe base para Onda genérica.
	*/
	public class RaioDeLuz extends Onda {
	
		/*
		* Contrutor, recebe posição e orientacao da onda
		*
		*/
		public function RaioDeLuz(ondulatoria:Ondulatoria, pOrig:Point,ang:Number,geracao:int, objeto:Objeto) {
			super(ondulatoria, pOrig,ang,geracao,objeto);
		}
	
		/*
		* 
		*/
		public override function  refratar(encontro:Encontro)
		{
			if(geracao<ondulatoria.limiteDeGeracao && encontro.objDest!=null)
			{
				var normAng:Number = encontro.angRetaNormal;
				
				//GraphAux.printLine(encontro.ponto, normAng);
				
				var angIncidencia:Number = MathAux.normAng(ang - normAng);
				//trace("ang Inc",angIncidencia);
				var angDeRef:Number;
				
				var indRefDest:Number = encontro.objDest.material.getIndRefr(encontro.onda);
				var indRefOrig:Number = encontro.objOrig.material.getIndRefr(encontro.onda);
				
				if(encontro.saindo)
				{
					//trace("saindo");
					angDeRef = MathAux.normAng(normAng + Math.asin( Math.sin(angIncidencia)*indRefOrig/indRefDest ));
					//trace("refratando: ponto:"+encontro.ponto+" incides n1,n2:"+indRefOrig+","+encontro.indRefDest+"|angR:"+angDeRef+"|angN:"+normAng+"|ang: "+ ang);
					//trace("angulo:",ang,normAng,angIncidencia,angDeRef,indRefOrig,indRefDest);
				}
				else
				{
					//trace("entrando");
					angIncidencia = MathAux.normAng(angIncidencia + Math.PI);
					angDeRef = MathAux.normAng(normAng - Math.PI+ Math.asin( Math.sin(angIncidencia)*indRefOrig/indRefDest ));
					//trace("refratando: ponto:"+encontro.ponto+" incides n1,n2:"+indRefOrig+","+encontro.indRefDest+"|angR:"+angDeRef+"|angN:"+normAng+"|ang: "+ ang);
				}
				
				
				if(isNaN(angDeRef)) //relexão total!
				{
					angDeRef = normAng-angIncidencia+Math.PI;
					this.ondaRefr = new RaioDeLuz(ondulatoria,encontro.ponto, angDeRef, geracao+1,encontro.objOrig);
					//trace(normAng,angDeRef);
				}
				else
				{
					this.ondaRefr = new RaioDeLuz(ondulatoria,encontro.ponto, angDeRef, geracao+1,encontro.objDest);
				}
				//trace("angulo:",ang,normAng,angIncidencia,angDeRef,indRefOrig,indRefDest);
				ondulatoria.propagarOnda(this.ondaRefr);
				
			}
		}
	
		/*
		*
		*/
		public override function refletir(encontro:Encontro)
		{
			
		}
			
		/*
		*
		*/
		public override function desenharMe() 
		{
			this.desenho = new Sprite();
			ondulatoria.container.addChild(desenho);

			desenho.graphics.lineStyle(2, 0x990000, .75);
			desenho.graphics.moveTo(pos.x, pos.y);
			desenho.graphics.lineTo(pFinal.x, pFinal.y);
		}

	}
}