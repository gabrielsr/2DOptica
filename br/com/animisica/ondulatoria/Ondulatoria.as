package br.com.animisica.ondulatoria
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import br.com.animisica.ondulatoria.*;
	
	/*
	* Classe Ondulatoria e a classe básica que controla um subuniverso optico, contem fontes de luz primarias
	* e objetos que interagem com a luz.
	*/
	public class Ondulatoria
	{

		public var fontes:Array;
		
		private var objetos:Array;
		
		public var container:Sprite; //contem as ondas
		
		var limiteDeGeracao:int;
		
		/*
		* Construtor
		* o container deve ser um sprite que se mostra acima dos objetos e abaixo das fontes no stage
		*/
		public function Ondulatoria(container:Sprite,limiteDeGeracao:int=10)
		{
			this.fontes = new Array();
			this.objetos = new Array();
			this.limiteDeGeracao = limiteDeGeracao;
			this.container = container;
			
		}
	
		/*
		* Adiciona um Objeto
		*/
		public function addObjeto(objeto:Objeto)
		{
			if(objetos.indexOf(objeto)==-1)
			{
				objetos.push(objeto);
			}
			//trace("Objeto adicionado com sucesso!");			
		}
		
		/*
		* Adiciona uma Fonte
		*/
		public function addFonte(fonte:FonteDeOnda):Onda
		{
			//procura para ver se a fonte já se encontra no array
			if(fontes.indexOf(fonte)==-1)
			{
				fontes.push(fonte);
			}

			var onda:Onda = new RaioDeLuz(this,fonte.pos,fonte.ang,1,null);
			var objeto:Objeto = procurarMeioEmBaixo(onda);
			if(objeto==null)
			{
				trace("fonte fora");
				return null;
			}
			trace(objeto.material.nome);
			onda.objeto=objeto;
			propagarOnda(onda);
			
			return onda;
		}
			
		/*
		* procura o meio em que uma onda está entre os que estão abaixo de um determinado objeto
		* se o objeto for nulo, procurar qualquer objeto
		*/
		public function procurarMeioEmBaixo(fonte:FonteDeOnda,objeto:Objeto=null):Objeto
		{
			var i:int;
			if( (objeto!=null) && (objetos.indexOf(objeto)>0) )
			{
				//início da busca no objeto a baixo da referência
				i = objetos.indexOf(objeto)-1;
			}
			else
			{
				i = objetos.length-1;
			}
			
			for (i;i>=0;i--)
			{
				if(objetos[i].dentro(fonte))
				{
					return objetos[i];
				}
			}
			
			return null;

		}
		
		function propagarOnda(onda:Onda)
		{
			var encontro:Encontro;
			//trace("adicionadando onda ... ");
			//trace("chamando procura de encontro");
			encontro = procEncontro(onda);
			//trace("proucarando encontro concluido!");
			if(encontro==null)
			{
				trace("Não encontrou fronteira, provavelmente existe algum erro")
				return null
			}
			//trace("propagando!");
			onda.propagarAte(encontro);
			onda.refratar(encontro);
			onda.refletir(encontro);

		}
		
		public function procEncontro(onda:Onda):Encontro
		{
			var maisProxEncontro:Encontro = null;
			var encontroTemp:Encontro;
			var objOrig:Objeto = onda.objeto;
			
			var i:int;

			//procurar a mais próxima SAIDA no PRÓPRIO OBJETO
			maisProxEncontro = objOrig.testaSaida(onda);
			
			//procurar a mais próxima ENTRADA com OBJETOS SUPERIORES
			if( objetos.indexOf(objOrig)>0 )
			{
				//início da busca no objeto a cima da referência
				i = objetos.indexOf(objOrig)+1;
			}
			else
			{
				i = 0;
			}
			
			for (i;i<objetos.length;i++)
			{
				//trace(i)
				//trace(objetos[i]);
				//trace(objetos);
				encontroTemp=objetos[i].testaEntrada(onda);
				//trace(encontroTemp);

				if(encontroTemp!=null) 
				{
					//então encontrou!
					if(maisProxEncontro==null || (encontroTemp.dist < maisProxEncontro.dist) )
					{
						//trace("encontrado encontro mais próximo!");
						maisProxEncontro = encontroTemp;
					}
					//armazena o par distância, encontro em um array
				}
			}
			
			if(maisProxEncontro==null)
			{
				return null;
			}
			
			if(maisProxEncontro.saindo)
			{
				// resolve quem é o objeto destino
				var ondaTeste:Onda = new OndaTeste(maisProxEncontro.ponto, maisProxEncontro.angRetaNormal);
				maisProxEncontro.objDest = procurarMeioEmBaixo(ondaTeste,objOrig);
			}
			else
			{
				// resolve quem é o objeto origem
				maisProxEncontro.objOrig = onda.objeto;
			}
			
			return maisProxEncontro;
		}
			
	
		/*
		* Manda mensagens para as fontes de luz, para que apaguem seus raios (se já existentes) e criem novos.
		* 
		*/
		public function atualizarTudo()
		{
			var fonteTemp:FonteDeOnda;
			for each (fonteTemp in fontes)
			{
				fonteTemp.atualizar();
			}
		}
	}
}