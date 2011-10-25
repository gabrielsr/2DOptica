package br.com.animisica.ondulatoria
{
	import br.com.animisica.ondulatoria.*;
	/*
	* O Material indica como as propriedades ópticas do objeto
	*/
	public class Material
	{
		private var indRefr:Number;
		public var nome:String;
		public function Material(indRefr:Number, nome:String)
		{
			this.indRefr=indRefr;
			this.nome = nome;
		}
		
		public function getIndRefr(onda:Onda):Number
		{
			return this.indRefr;
		}
	}
}