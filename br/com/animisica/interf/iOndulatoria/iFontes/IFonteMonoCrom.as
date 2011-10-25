package br.com.animisica.interf.iOndulatoria.iFontes
{
	import br.com.animisica.ondulatoria.Objeto;
	import flash.events.MouseEvent;
	
	public class  IFonteMonoCrom extends IFonte
	{
		//sprite controlada pelo iElemento
		//private var mySprite:Sprite;
		//private var ondObjeto:Objeto;
		//private var nome:String;
		//private var meuDesenho:Sprite;
		
		public function IFonteMonoCrom(iReg:IRegistro, x:Number,y:Number, angulo:Number)
		{
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
		
		/*
		* Ações tomadas quando o elemento sofre um doubleClick. 
		* É registrado um listener para essa ação que aponta para esse método
		*/
		public override function doubleClick(e:MouseEvent)
		{
			//apaga menu anterior
			//coloca o menu em posição
			//chama registraListeners
			registraListenersSelecionado();
			registraListenerTeclado();
			marcarComoSeleto();	
			//
		}
		
		
		
		/*
		* Função que deve ser sobrescrita nas classes derivadas
		*/
		public override function registraListenersSelecionado()
		{
		}
		
		public override function registraListenerTeclado()
		{
			//gira
			//se move
		}
		
		public override function apagaListenersTeclado()
		{
			
		}
		
		/*
		* Desenha algum destaque em um objeto quando ele for selecionado
		*/
		public override function marcarComoSeleto()
		{
		}
		
		public override function aplicarNome(novoNome:String)
		{
			this.nome = novoNome;
			//mais alguma ação quanto ao movieClip
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
		}
	}
}