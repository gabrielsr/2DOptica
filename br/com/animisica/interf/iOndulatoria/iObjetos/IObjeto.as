package br.com.animisica.interf.iOndulatoria.iObjetos
{
	import br.com.animisica.ondulatoria.*;
	import br.com.animisica.interf.iOndulatoria.*;
	import flash.events.MouseEvent;
	
	public class IObjeto extends IElemento
	{
		//sprite controlada pelo iElemento
		//private var mySprite:Sprite;
		var objeto:Objeto;
		//private var nome:String;
		
		public function IObjeto(iReg:IRegistro, x:Number,y:Number, angulo:Number,material:Material)
		{
			objeto = new Objeto(material);
			iReg.ondulatoria.addObjeto(objeto);
			iReg.contObjetos.addChild(this);
			super(iReg, x,y,angulo);
			
		}

		/*
		* Cria a representação óptica na engine (br.com.animisica.ondulatoria)
		* deve ser sobrescrito
		*/
		public override function ciarElementoOptico()
		{
			
		}
		
		
		/*
		* Atualiza os dados na representação óptica na engine (br.com.animisica.ondulatoria)
		* deve ser sobrescrito
		*/
		public override function atualizaElementoOptico()
		{
		}
		
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