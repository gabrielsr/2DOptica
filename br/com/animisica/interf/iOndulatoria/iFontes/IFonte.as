package br.com.animisica.interf.iOndulatoria.iFontes
{
	import br.com.animisica.ondulatoria.Objeto;
	import br.com.animisica.ondulatoria.*;
	import br.com.animisica.interf.iOndulatoria.iFontes.*;
	import br.com.animisica.interf.iOndulatoria.*;


	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Sprite;
	import flash.geom.Point;

	public class IFonte extends IElemento
	{
		//sprite controlada pelo iElemento
		//private var mySprite:Sprite;
		//private var ondObjeto:Objeto;
		//private var nome:String;
		//private var meuDesenho:Sprite;
		public var fonte:FonteDeOnda;
		
		public function IFonte(iReg:IRegistro, x:Number,y:Number, angulo:Number)
		{
			iReg.contFontes.addChild(this);
			super(iReg, x,y,angulo);

		}
		
		/*
		* Cria a representação óptica na engine (br.com.animisica.ondulatoria)
		* deve ser sobrescrito
		*/
		public override function ciarElementoOptico()
		{
			var angRad:Number = rotation*Math.PI/180;
			fonte = new FonteDeOnda(iReg.ondulatoria, new Point(x,y),angRad);
			fonte.criarOnda();
				
		}
		
		/*
		* Cria a representação gráfica no stage
		* deve ser sobrescrito
		*/
		public override function ciarDesenho()
		{
			this.graphics.clear();
			this.graphics.lineStyle(0,0x000000,10);
			this.graphics.beginFill(0);
			this.graphics.drawRect(0, 4, -30, -8);
			
			//meuDesenho.graphics.fillRect(x-30, y-4, 30, 8);
		}

		
		/*
		* Atualiza os dados na representação óptica na engine (br.com.animisica.ondulatoria)
		* deve ser sobrescrito
		*/
		public override function atualizaElementoOptico()
		{
			fonte.pos.x = x
			fonte.pos.y = y;

			fonte.ang = rotation*Math.PI/180;
			
			fonte.atualizar();
		}
		
		
		/*
		* Método deve ser sobresctio
		* transforma as informações desse elemento em uma tag xml. Retorna uma string com a tag. 
		*/
		public override function toXML():String
		{
			return null;
		}
		
		/* 
		* Apartir dos dados gerados em toXML, monta o elemento novamente
		*/
		public override function fromXML():String
		{
			return null;
		}
	}
}