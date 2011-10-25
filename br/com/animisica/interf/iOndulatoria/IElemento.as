package br.com.animisica.interf.iOndulatoria
{
	import br.com.animisica.ondulatoria.Objeto;
	import flash.display.Sprite;
	
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Sprite;
	import flash.geom.Point;
	

	public class IElemento extends Sprite
	{

		//var ondObjeto:Objeto;
		//public var meuDesenho:Sprite;
		public var iReg:IRegistro;

		public 	var nome:String;
		
		//public 	var x:Number;
		//public 	var y:Number
		//public 	var angulo:Number;

		
		public function IElemento(iReg:IRegistro, x:Number,y:Number, angulo:Number)
		{
			this.iReg = iReg;
			
			this.x = x;
			this.y = y;
			this.rotation = angulo;

			//this.meuDesenho = new Sprite();
			//meuDesenho.x=x;
			//meuDesenho.y=y;
			

			ciarElementoOptico();
			ciarDesenho();
			
			registraListenersSelecionado();
			
			//ciarElementoOptico();
			//ciarDesenho();

		}

		/*
		* Cria a representação óptica na engine (br.com.animisica.ondulatoria)
		* deve ser sobrescrito
		*/
		public function ciarElementoOptico()
		{
			
		}
		/*
		* Cria a representação gráfica no stage
		* deve ser sobrescrito
		*/
		public function ciarDesenho()
		{

		}		
		
		/*
		* Atualiza os dados na representação óptica na engine (br.com.animisica.ondulatoria)
		* deve ser sobrescrito
		*/
		public function atualizaElementoOptico()
		{
		}
	
				/*
		* Ações tomadas quando o elemento sofre um doubleClick. 
		* É registrado um listener para essa ação que aponta para esse método
		*/
		public function simpleClick(e:MouseEvent)
		{
			//focus=meuDesenho;
			//trace("ops, fui clicado");
			iReg.stg.focus = this;

			registraListenersSelecionado();
			registraListenerTeclado();
			marcarComoSeleto();	
			//

		}

		/*
		* Função que deve ser sobrescrita nas classes derivadas
		*/
		public function registraListenersSelecionado()
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, simpleClick);
			//trace("registra listener");
		}
		
		public function registraListenerTeclado()
		{
			function keyPressed(event:KeyboardEvent):void
			{
				//trace("tecla apertada!");
				if(event.keyCode == Keyboard.DOWN)
				{
					y+=1;
				}
				else if(event.keyCode == Keyboard.UP)
				{
					y-=1;
				}
				else if(event.keyCode == Keyboard.LEFT)
				{
					x-=1;
				}
				else if(event.keyCode == Keyboard.RIGHT)
				{
					x+=1;
				}
				else if(event.keyCode == Keyboard.PAGE_DOWN)
				{
					rotation+=1;
				}
				else if(event.keyCode == Keyboard.PAGE_UP)
				{
					rotation-=1;
				}
				else if(event.keyCode == Keyboard.HOME)
				{
					rotation = 0;
				}
				else if(event.keyCode == Keyboard.END)
				{
					rotation = 180;
				}
				atualizaElementoOptico();
				//trace(x,y)

			}
			this.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);

		}
		
		public function apagaListenersTeclado()
		{
			
		}
		
		/*
		* Desenha algum destaque em um objeto quando ele for selecionado
		*/
		public function marcarComoSeleto()
		{
		}
		
		public function aplicarNome(novoNome:String)
		{
			this.nome = novoNome;
			//mais alguma ação quanto ao movieClip
		}
		
				
		/*
		* Método deve ser sobresctio
		* transforma as informações desse elemento em uma tag xml. Retorna uma string com a tag. 
		*/
		public function toXML():String
		{
			return null;
		}
		
		/* 
		* Apartir dos dados gerados em toXML, monta o elemento novamente
		*/
		public function fromXML():String
		{
			return null;
		}
	}
}