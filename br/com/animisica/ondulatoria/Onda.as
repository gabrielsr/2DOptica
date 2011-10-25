package br.com.animisica.ondulatoria
{
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import br.com.animisica.ondulatoria.SuperfOnd;
	import br.com.animisica.ondulatoria.*;
	
	
	/*
	* Classe base para Onda genérica.
	*/
	public class Onda extends FonteDeOnda
	{
		
		//Origem da onda
		//Final da Onda
		public var pFinal:Point;

		
		//Onda Mae
		public var ondaMae:Onda;
					
		//Objeto que representa o meio no qual a onda está se propagando
		public var objeto:Objeto;
		
		public var geracao:int;

		//sprite onda a onda se desenha
		var desenho:Sprite;
		
		var ondaRefl:Onda;
		var ondaRefr:Onda;
		/*
		* Contrutor, recebe posição e orientacao da onda
		*
		*/
		public function Onda(ondulatoria:Ondulatoria, pOrig:Point,ang:Number, geracao:int,objeto:Objeto)
		{
			this.geracao = geracao;
			this.objeto = objeto;
			
			super(ondulatoria, pOrig, ang);
		}
		
		/* 
		* Propagar
		*/
		public function propagarAte(encontro:Encontro)
		{
			this.pFinal = encontro.ponto;
			desenharMe();
		}
	

		/* 
		* Apaga a si e as ondas filhas
		*/
		public function apagarRecursivo()
		{
			if(desenho!=null)
			{
				ondulatoria.container.removeChild(desenho);
				desenho = null;
			}
			if(ondaRefl!=null)
			{
				ondaRefl.apagarRecursivo();
				ondaRefl = null;
			}
				
			if(ondaRefr!=null)
			{
				ondaRefr.apagarRecursivo();
				ondaRefr = null;
			}
		}
		
		/*
		*
		*/
		public function refletir(encontro:Encontro)
		{
		}
	
	
		/*
		*
		*/
		public function refratar(encontro:Encontro)
		{
		}
		
		/*
		*
		*/
		public function desenharMe()
		{
		
		}
	}
}