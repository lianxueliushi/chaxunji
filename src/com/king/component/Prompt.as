package com.king.component
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.king.control.ViewObject;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Prompt extends ViewObject
	{
		/**
		 *提示信息 
		 */
		private var _biMessage:TextField;
		/**
		 *背景框 
		 */		
		private var _busyBg:ViewObject;
		/**
		 *高度 
		 */		
		private var _heg:int=30;
		public function Prompt()
		{
			super();
		}
		
		override protected function onInit():void
		{
			// TODO Auto Generated method stub
			_busyBg=new ViewObject();
			this.addChild(_busyBg);
			_busyBg.visible=false;
			
			_biMessage=new TextField();
			_biMessage.selectable=false;
			_biMessage.embedFonts=true;
			_biMessage.textColor=0xffffff;
			var fm:TextFormat=new TextFormat();
			fm.size=16;
			fm.font=new Font_WRYH().fontName;
			fm.align="center";
			_biMessage.defaultTextFormat=fm;
			_biMessage.text="提示信息";
			_biMessage.height=_biMessage.textHeight+6;
			_busyBg.addChild(_biMessage);
			_biMessage.y=_heg-_biMessage.height>>1;
		}
		public function showMessage($str:String,$autoDispear:Boolean=false,delay:Number=2):void{
			_biMessage.text=$str;
			_biMessage.autoSize=TextFieldAutoSize.LEFT;
			
			_busyBg.graphics.clear();
			_busyBg.graphics.beginFill(0x333333);
			_busyBg.graphics.drawRoundRect(0,0,_biMessage.width+50,_heg,5);
			_busyBg.graphics.endFill();
			_biMessage.x=25;
			_busyBg.visible=true;
			_busyBg.alpha=1;
			_biMessage.alpha=1;
			TweenLite.from(_busyBg,0.6,{alpha:0,ease:Circ.easeOut});
			
			if($autoDispear){
				TweenLite.delayedCall(delay,hiddenMessage);
			}
			
		}
		public function hiddenMessage():void{
			_busyBg.visible=false;
		}
		
	}
}