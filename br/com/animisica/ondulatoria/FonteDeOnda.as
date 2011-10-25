package br.com.animisica.ondulatoria
{
	import flash.geom.Point;
	import br.com.animisica.ondulatoria.*;
	
	public class FonteDeOnda{
		
		//Posição da fonte
		public var pos:Point;
		
		//angulo com a horizontal
		public var ang:Number;

		//referência a classe mestre
		var ondulatoria:Ondulatoria;
				
		//seno e cosseno do angulo
		public var sinAng:Number;
		public var cosAng:Number;

		//onda filha
		public var ondaFilha:Onda;
		
		public function FonteDeOnda(ondulatoria:Ondulatoria, pos:Point, ang:Number)
		{
			this.sinAng = Math.sin(ang);
			this.cosAng = Math.cos(ang);
			
			this.ondulatoria=ondulatoria;
			this.pos=pos;
			
			ang=MathAux.normAng(ang);
			//trace("ang: ",ang);
			
			this.ang=ang;

		}
		
		public function criarOnda()
		{	
			ondaFilha = ondulatoria.addFonte(this);
		}

		public function apagar()
		{
			if(ondaFilha!=null)
			{
				ondaFilha.apagarRecursivo();
				ondaFilha = null;
			}
			//trace("apaaaaaaaaaaaaaga!");
		}
		public function atualizar()
		{
			apagar();
			criarOnda();
		}
	}
}