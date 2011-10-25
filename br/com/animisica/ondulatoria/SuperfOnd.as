package br.com.animisica.ondulatoria
{
	import flash.geom.Point;
	
	/*
	* Classe base para superficie genérica
	* um superficie é um lugar onde a mudança de meios e pode ocorrer reflexão ou refração
	*/
	
	public class SuperfOnd
	{
		//essa classe não pode ser usada diretamente.
		//deve ser usada suas derivadas, como SuperficieOndPlana ou SuperficieOndEsferica
		
		/*
		* testa o encontro do raio de luz com a superficie
		* se encontra, retorna o ponto de encontro
		* se nao encontra, retorna null
		* método abstrato, deve ser implementado nas classes derivadas.
		*/
		public function atualizarSuperficie(){}
		public function testaEncontro(onda:Onda):Encontro{return null;}

		public function testaEntrada(onda:Onda):Encontro
		{
			var encontro = testaEncontro(onda);
			if(encontro!=null && encontro.saindo==false)
			{
				return encontro;
			}

			return null;

		}

		public function testaSaida(onda:Onda):Encontro
		{
			var encontro = testaEncontro(onda);
			if(encontro!=null && encontro.saindo==true)
			{
				return encontro;
			}

			return null;
		}		

		public function angRetaNormal(onda:Onda,ponto:Point):Number{return 0;}
	}
}