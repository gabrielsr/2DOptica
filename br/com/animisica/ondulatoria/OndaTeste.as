package br.com.animisica.ondulatoria
{
	import flash.geom.Point;
	import flash.display.Graphics;
	import br.com.animisica.ondulatoria.*;
	
	/*
	* Classe base para Onda genérica.
	*/
	public class OndaTeste extends Onda {
	
		public function OndaTeste(pOrig:Point,ang:Number)
		{
			super(null, pOrig,ang,0,null);
		}
	}
}