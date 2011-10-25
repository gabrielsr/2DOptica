package br.com.animisica.interf.iOndulatoria
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class IRegistro
	{
		import br.com.animisica.ondulatoria.*;
		
		public var ondulatoria:Ondulatoria;

		private var container:Sprite;
		
		public var contObjetos:Sprite;
		public var contOndas:Sprite;
		public var contFontes:Sprite;
		public var stg:Stage;
		
		public function IRegistro(container:Sprite, stg:Stage)
		{
			this.container = container;

			this.contObjetos = new Sprite();
			container.addChild(contObjetos);
			this.contOndas = new Sprite();
			container.addChild(contOndas);
			this.contFontes = new Sprite();
			container.addChild(contFontes);
			
			this.ondulatoria = new Ondulatoria(this.contOndas);
			this.stg = stg;
		}
		public function atualizarTudo()
		{
			ondulatoria.atualizarTudo();
		}
		public function addElemento()
		{
		}
		public function salvaConf()
		{
		}
		public function abreConf()
		{
		}
	}
}