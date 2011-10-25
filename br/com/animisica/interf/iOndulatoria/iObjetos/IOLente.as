package br.com.animisica.interf.iOndulatoria.iObjetos
{
	import br.com.animisica.ondulatoria.Objeto;
	import br.com.animisica.ondulatoria.*;
	import br.com.animisica.interf.iOndulatoria.iObjetos.*;
	import br.com.animisica.interf.iOndulatoria.*;
	
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Sprite;
	import flash.geom.Point;

	
	public class IOLente extends IObjeto
	{
		//sprite controlada pelo iElemento
		//private var mySprite:Sprite;
		//private var ondObjeto:Objeto;
		//private var nome:String;
		//private var this:Sprite;
		//private var x:Number;
		//private var y:Number
		
		public var esp:Number; //espessura da lente
		public var altura:Number;
		var dist:Number;
		public var r1:Number; //raio da superfície esquerda
		public var r2:Number; //raio da superfície direita

		private var pC1Rel:Point;
		private var pC2Rel:Point;
		private var pSup1Rel:Point;
		private var pSup2Rel:Point;
		private var pInf1Rel:Point;
		private var pInf2Rel:Point;
		
		private var aIni1Rel:Number;
		private var aIni2Rel:Number;

		private var pC1Abs:Point;
		private var pC2Abs:Point;
		private var pSup1Abs:Point;
		private var pSup2Abs:Point;
		private var pInf1Abs:Point;
		private var pInf2Abs:Point;

		private var aIni1Abs:Number;
		private var aIni2Abs:Number;

		private var abert1:Number;
		private var abert2:Number;
		
		private var v1x:Number;
		private var v2x:Number;
		
		private var planaSup:SuperficieOndPlana;
		private var planaInf:SuperficieOndPlana;
		private var curva1:SuperficieOndCircular;
		private var curva2:SuperficieOndCircular;

		public function IOLente(iReg:IRegistro, x:Number,y:Number, altura:Number, angulo:Number, r1:Number,r2:Number, material:Material)
		{
			this.altura = altura;
			this.r1 = r1;
			this.r2 = r2;
						
			//valores default
			this.esp = 20; 
			//this.altura = 100;
			
			super(iReg, x,y,angulo,material);
			
						
		}

		/*
		* Cria a representação óptica na engine (br.com.animisica.ondulatoria)
		*/
		public override function ciarElementoOptico()
		{
			trace("criando elemento óptico");
			
			pC1Rel = new Point();
			pC2Rel = new Point();
			pSup1Rel = new Point();
			pSup2Rel = new Point();
			pInf1Rel = new Point();
			pInf2Rel = new Point();
						
			
			this.planaSup = new SuperficieOndPlana(pSup1Rel,pSup2Rel);
			this.planaInf = new SuperficieOndPlana(pInf1Rel,pInf2Rel);
			this.curva1 = new SuperficieOndCircular(pC1Rel, 0, 0, 0);
			this.curva2 = new SuperficieOndCircular(pC1Rel, 0, 0, 0);

			objeto.superficies[0]= curva1;
			objeto.superficies[1]= curva2;
			objeto.superficies[2]= planaSup;
			objeto.superficies[3]= planaInf;
			
			 atualizarFormaElementoOptico();
			
		}
				
		/*
		* Atualiza a representação óptica na engine (br.com.animisica.ondulatoria)
		*/
		public function atualizarFormaElementoOptico()
		{
			if( (Math.abs(r1)<altura/2)||(Math.abs(r2)<altura/2) )
			{
				trace("um dos raios é pequeno de mais");
				return null;
			}
			
			var s1:Number;
			var s2:Number;
						
			
			
			var meiaAbertura:Number;
			
			if(r1>0)
			{
				s1 = r1 - esp - Math.sqrt(r1*r1 - (altura*altura)/4);
				meiaAbertura = Math.asin(altura/(2*r1));
				aIni1Rel= Math.PI - meiaAbertura;
				abert1 = 2*meiaAbertura;
				trace("supCir1",r1,s1,meiaAbertura,aIni1Rel, abert1);
			}else
			{
				s1 = r1 - esp + Math.sqrt(r1*r1 - (altura*altura)/4);
				meiaAbertura = Math.asin(altura/(2*r1));
				aIni1Rel= - meiaAbertura;
				abert1 = 2*meiaAbertura;
				trace("supCir1",r1,s1,meiaAbertura,aIni1Rel, abert1);
			}
			if(r2>0)
			{
				s2 = r2 + esp - Math.sqrt(r2*r2 - (altura*altura)/4);
				meiaAbertura = Math.asin(altura/(2*r2));
				aIni2Rel= Math.PI + meiaAbertura;
				abert2 = 2*meiaAbertura;
				trace("supCir2",r2,s2,meiaAbertura,aIni2Rel, abert2);
			}else
			{
				s2 = r2 + esp + Math.sqrt(r2*r2 - (altura*altura)/4);
				meiaAbertura = Math.asin(altura/(2*r2));
				aIni2Rel= meiaAbertura;
				abert2 = 2*meiaAbertura;
				trace("supCir2",r2,s2,meiaAbertura,aIni2Rel, abert2);
			}
			
			dist = s2 - s1;
			trace("dist:",dist);
			
			//verifica se tem espaço entre os topos das curvas
			// se negativo é porque as curvas estão se encontrando
			if(dist>0)
			{
				dist=0;

				//coloca as superficies planas
				//objeto.superficies[2]= planaSup;
				//objeto.superficies[3]= planaInf;	
			}
			else
			{				
				//retira as superficies planas
				
				//objeto.superficies.splice(2,2);
			}
				pSup1Rel.x = s1+ dist/2;
				pInf1Rel.x = s1+ dist/2;

				pSup2Rel.x = s2- dist/2;
				pInf2Rel.x = s2- dist/2;

				pInf1Rel.y = -1*altura/2;
				pInf2Rel.y = -1*altura/2;
	
				pSup1Rel.y = altura/2;
				pSup2Rel.y = altura/2;
				
				v1x = -esp + dist/2;
				v2x = +esp - dist/2;

			pC1Rel.x = r1 -esp + dist/2;
			pC2Rel.x = r2 +esp - dist/2;
			pC1Rel.y = 0;
			pC2Rel.y = 0;
			
			atualizarPosicaoElementoOptico();
			
		}
		
		/*
		* Atualiza a representação óptica na engine (br.com.animisica.ondulatoria)
		*/
		public function atualizarPosicaoElementoOptico()
		{
			trace("atualizando posições");
			pC1Abs = MathAux.translada(pC1Rel.x,pC1Rel.y,this.x, this.y, this.rotation*Math.PI/180);
			pC2Abs = MathAux.translada(pC2Rel.x,pC2Rel.y,this.x, this.y, this.rotation*Math.PI/180);
			pSup1Abs = MathAux.translada(pSup1Rel.x,pSup1Rel.y,this.x, this.y, this.rotation*Math.PI/180);
			pSup2Abs = MathAux.translada(pSup2Rel.x,pSup2Rel.y,this.x, this.y, this.rotation*Math.PI/180);
			pInf1Abs = MathAux.translada(pInf1Rel.x,pInf1Rel.y,this.x, this.y, this.rotation*Math.PI/180);
			pInf2Abs = MathAux.translada(pInf2Rel.x,pInf2Rel.y,this.x, this.y, this.rotation*Math.PI/180);

			aIni1Abs = aIni1Rel + this.rotation*Math.PI/180;
			aIni2Abs = aIni2Rel + this.rotation*Math.PI/180;
			
			curva1.pCentro = pC1Abs;
			curva1.raio = r1;
			curva1.angIni = aIni1Abs ;
			curva1.angAbertura = abert1;

			curva2.pCentro = pC2Abs;
			curva2.raio = r2;
			curva2.angIni = aIni2Abs ;
			curva2.angAbertura = -abert2;
			
			planaSup.pR1 = pSup2Abs; 
			planaSup.pR2 = pSup1Abs;
			planaSup.atualizarSuperficie();
			planaInf.pR1 = pInf1Abs;
			planaInf.pR2 = pInf2Abs;
			planaInf.atualizarSuperficie();			
			
		}
		/*
		* Cria a representação gráfica no stage
		* deve ser sobrescrito
		*/
		public override function ciarDesenho()
		{

			this.graphics.clear();
			this.graphics.lineStyle(0,0x000000,1);
			this.graphics.beginFill(0xAAAAAA,1);
			this.graphics.moveTo(pSup1Rel.x,pSup1Rel.y);
			this.graphics.lineTo(pSup2Rel.x,pSup2Rel.y);

			this.graphics.curveTo(v2x,Math.tan(abert2/4)*r2,v2x, 0);
			this.graphics.curveTo(v2x,-Math.tan(abert2/4)*r2,pInf2Rel.x, pInf2Rel.y);
			//this.graphics.lineTo(v2x,0);
			//this.graphics.lineTo(pInf2Rel.x,pInf2Rel.y);
			
			this.graphics.lineTo(pInf1Rel.x,pInf1Rel.y);
			//this.graphics.lineTo(v1x,0);
			this.graphics.curveTo(v1x,-Math.tan(abert1/4)*r1,v1x,0);
			this.graphics.curveTo(v1x,Math.tan(abert1/4)*r1,pSup1Rel.x,pSup1Rel.y);
			//this.graphics.lineTo(pSup1Rel.x,pSup1Rel.y);
			
			
		}
		
		
		/*
		* Atualiza os dados na representação óptica na engine (br.com.animisica.ondulatoria)
		* deve ser sobrescrito
		*/
		public override function atualizaElementoOptico()
		{
			atualizarFormaElementoOptico();
			iReg.atualizarTudo();
		}
		
	
	}
}