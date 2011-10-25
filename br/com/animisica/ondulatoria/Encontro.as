package br.com.animisica.ondulatoria
{
	import flash.geom.Point;
	public class Encontro
	{
		public var ponto:Point;
		public var angRetaNormal:Number;
		public var onda:Onda;
		
		public var objOrig:Objeto;
		public var objDest:Objeto;

		public var angIncidencia:Number;
		public var saindo:Boolean;
		public var dist:Number;
		
		public function Encontro(ponto:Point, angRetaNormal:Number, onda:Onda)
		{
			this.ponto = ponto;
			this.angRetaNormal = angRetaNormal;
			this.onda = onda;
			
			this.angIncidencia = MathAux.normAng(onda.ang - angRetaNormal);
			this.dist = Point.distance(ponto, onda.pos);
			
			if(angIncidencia> Math.PI/2 ||angIncidencia< (-1*Math.PI/2) ) // onda entrando - normal oposta a incidente
			{
				this.saindo=false;
				trace("entrando");
			}
			else //onda saindo
			{
				this.saindo=true;
			}
			
			

		}
	}
}