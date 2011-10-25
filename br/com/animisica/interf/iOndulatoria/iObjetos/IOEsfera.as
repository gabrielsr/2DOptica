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

	
	public class IOEsfera extends IObjeto
	{
		public var r1:Number; //raio da superfície esquerda
		public var pCentroRel;
		public var pCentroAbs;

		public function IOEsfera(iReg:IRegistro, x:Number,y:Number, r1:Number,material:Material)
		{

			this.r1 = r1;
			pCentroRel = new Point(0,0);
			
			super(iReg, x,y,0,material);
						
		}

		/*
		* Cria a representação óptica na engine (br.com.animisica.ondulatoria)
		*/
		public override function ciarElementoOptico()
		{
			pCentroAbs = MathAux.translada(pCentroRel.x,pCentroRel.y,this.x, this.y, this.rotation*Math.PI/180);
			trace(pCentroRel);
			trace(pCentroAbs);
			objeto.superficies[0]= new SuperficieOndCircular(pCentroAbs, r1, 0, -2*Math.PI);
			objeto.superficies[1]= new SuperficieOndCircular(pCentroAbs, 2*r1, 0, 2*Math.PI);
			//atualizarFormaElementoOptico();
		}
				
		/*
		* Atualiza a representação óptica na engine (br.com.animisica.ondulatoria)
		*/
		public function atualizarFormaElementoOptico()
		{
		
			//objeto.superficies[0].pCentro = 
			objeto.superficies[0].pCentro = MathAux.translada(pCentroRel.x,pCentroRel.y,this.x, this.y, this.rotation*Math.PI/180);
			objeto.superficies[1].pCentro = objeto.superficies[0].pCentro 
		}
		
		/*
		* Atualiza a representação óptica na engine (br.com.animisica.ondulatoria)
		*/
		public function atualizarPosicaoElementoOptico()
		{
			
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
			this.graphics.drawCircle(pCentroRel.x, pCentroRel.y,r1);
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