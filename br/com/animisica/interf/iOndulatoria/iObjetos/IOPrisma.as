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

	
	public class IOPrisma extends IObjeto
	{
		//sprite controlada pelo iElemento
		//private var mySprite:Sprite;
		//private var ondObjeto:Objeto;
		//private var nome:String;
		//private var this:Sprite;
		//private var x:Number;
		//private var y:Number
		
		private var largura:Number;
		private var altura:Number;
		private var pontosRel:Array;
		private var pontosAbs:Array;
				
		public function IOPrisma(iReg:IRegistro, x:Number,y:Number, largura:Number, altura:Number, angulo:Number, material:Material)
		{
			this.largura = largura;
			this.altura = altura;
			pontosRel = new Array;
			pontosAbs = new Array;
			
			pontosRel[0] = new Point(-largura/2, -altura/2);
			pontosRel[1] = new Point(largura/2, -altura/2);
			pontosRel[2] = new Point(largura/2, +altura/2);
			pontosRel[3] = new Point(-largura/2, +altura/2);

			super(iReg, x,y,angulo,material);
		}

		/*
		* Cria a representação óptica na engine (br.com.animisica.ondulatoria)
		*/
		public override function ciarElementoOptico()
		{
			var i:int;
			
			for(i=0; i<pontosRel.length;i++)
			{
				pontosAbs[i] = MathAux.translada(pontosRel[i].x,pontosRel[i].y,this.x, this.y, this.rotation*Math.PI/180);

			}

			//adiciona as primeiras superficies
			for(i=0; i<pontosAbs.length-1;i++)
			{
				objeto.superficies[i]= new SuperficieOndPlana(pontosAbs[i],pontosAbs[i+1]);
			}
			//adiciona a última superfície
			objeto.superficies.push(new SuperficieOndPlana(pontosAbs[i],pontosAbs[0]));
		}
				
		/*
		* Atualiza a representação óptica na engine (br.com.animisica.ondulatoria)
		*/
		public function atualizarElementoOptico()
		{
			var i:int;
			
			for(i=0; i<pontosRel.length;i++)
			{
				pontosAbs[i] = MathAux.translada(pontosRel[i].x,pontosRel[i].y,this.x, this.y, this.rotation*Math.PI/180);
			}

			var sup:SuperficieOndPlana
			//adiciona as primeiras superficies
			for(i=0; i<pontosAbs.length-1;i++)
			{
				sup = objeto.superficies[i];
				sup.pR1 = pontosAbs[i];
				sup.pR2 = pontosAbs[i+1];
				sup.atualizarSuperficie();
			}
			//adiciona a última superfície
			sup = objeto.superficies[i];
			sup.pR1 = pontosAbs[i];
			sup.pR2 = pontosAbs[0];
			sup.atualizarSuperficie();

		}
		
		/*
		* Cria a representação gráfica no stage
		* deve ser sobrescrito
		*/
		public override function ciarDesenho()
		{
			this.graphics.clear();
			this.graphics.lineStyle(0,0x000000,1);
			this.graphics.beginFill(0xFFFFFF,1);
			this.graphics.drawRect(-largura/2, -altura/2, largura, altura);
		}
		
		
		/*
		* Atualiza os dados na representação óptica na engine (br.com.animisica.ondulatoria)
		* deve ser sobrescrito
		*/
		public override function atualizaElementoOptico()
		{
			atualizarElementoOptico();
			iReg.atualizarTudo();
		}
		
	
	}
}