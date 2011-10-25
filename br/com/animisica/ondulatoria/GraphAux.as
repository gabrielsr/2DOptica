package br.com.animisica.ondulatoria
{
	import flash.geom.Point;
	import flash.display.*;
	
	/*
	* Classe base para Onda genérica.
	*/
	public  class GraphAux 
	{
		static var cont:Sprite;
		static var graf:Sprite;
		
		public static function registrar(ref:Sprite)
		{
			cont = ref;
			graf = new Sprite();
		}
		public static function printPoint(ponto:Point)
		{
			var graf:Sprite = new Sprite();
			graf.graphics.lineStyle(2, 0x000000, .75);
			graf.graphics.drawCircle(ponto.x,ponto.y,1)
			cont.addChild(graf);
		}
		public static function printLine(ponto:Point, ang:Number)
		{
			//graf.graphics.clear();
			graf.graphics.lineStyle(2, 0x000000, .75);
			graf.graphics.moveTo(ponto.x,ponto.y);
			graf.graphics.lineTo(ponto.x+Math.cos(ang)*100, ponto.y+Math.sin(ang)*100);
			cont.addChild(graf);
		}

	}
}