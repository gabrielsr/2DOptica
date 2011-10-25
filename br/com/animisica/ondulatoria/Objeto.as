package br.com.animisica.ondulatoria
{
	public class Objeto
	{
		public var superficies:Array;
		public var material:Material;
		public function Objeto(material:Material)
		{
			this.material = material;
			this.superficies = new Array();
		}
		public function dentro(onda:Onda):Boolean
		{
			var sup:SuperfOnd;
			var saiu:int=0;
			var entrou:int=0;
			
			var encontro:Encontro;
			for each (sup in superficies)
			{
				encontro=sup.testaEncontro(onda);
				if(encontro!=null)
				{
					if(encontro.saindo)
					{
						saiu++;
					}
					else //se entrou uma vez é porque não está dentro
					{
						entrou++;
					}
				}
			}
			if(saiu>entrou)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function testaEntrada(onda:Onda):Encontro
		{
			var maisProxEncontro:Encontro;
			var encontroTemp:Encontro;
			var sup:SuperfOnd;
			
			
			
			for each ( sup in superficies)
			{
				
				//testa ENTRADA//////////////////////////////////////
				encontroTemp=sup.testaEntrada(onda);
				if(encontroTemp!=null) 
				{
					//então encontrou!
					if(maisProxEncontro==null || (encontroTemp.dist < maisProxEncontro.dist) )
					{
						//trace("encontrado encontro mais próximo!");
						maisProxEncontro = encontroTemp;
						maisProxEncontro.objDest = this;
					}
					//armazena o par distância, encontro em um array
				}
				//else trace("não encontrou!");
			}
			return maisProxEncontro;

		}
		
		public function testaSaida(onda:Onda):Encontro
		{
			var maisProxEncontro:Encontro = null;
			var encontroTemp:Encontro;
			var sup:SuperfOnd;
			
			for each ( sup in superficies)
			{
				
				//testa SAIDA//////////////////////////////////////
				encontroTemp=sup.testaSaida(onda);
				
				if(encontroTemp!=null) 
				{
					//então encontrou!
					if(maisProxEncontro==null || (encontroTemp.dist < maisProxEncontro.dist) )
					{
						//("encontrado encontro mais próximo!");
						maisProxEncontro = encontroTemp;
					}
					//armazena o par distância, encontro em um array
				}
				//else ("não encontrou!");
			}

			if(maisProxEncontro!=null)
			{
			   maisProxEncontro.objOrig = this;
			}
			return maisProxEncontro;
		}

		//moverObjeto();
	}
}
		