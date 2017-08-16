package com.king.component
{
	import com.king.control.VScrollControl;
	import com.king.control.ViewObject;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TxtContainer extends ViewObject
	{
		private var loader:URLLoader;
		private var textView:TextField;
		private var _textFormat:TextFormat;
		private var textContainer:VScrollControl;
		private var _wid:int;
		private var _heg:int;
		private var _url:String;
		public function TxtContainer($wid:Number, $heg:Number, $txtUrl:String,$tf:TextFormat=null)
		{
			_wid=$wid;
			_heg=$heg;
			if($tf){
				_textFormat=$tf;
			}
			else{
				_textFormat=new TextFormat();
				_textFormat.align=TextFormatAlign.LEFT;
				_textFormat.font=new Font_WRYH().fontName;
				_textFormat.size=18;
				_textFormat.color=0x222222;
				_textFormat.indent=18*2;
				_textFormat.letterSpacing=1;
				_textFormat.leading=5;
			}
			textView=new TextField();
			textView.defaultTextFormat=_textFormat;
			loader=new URLLoader();
			loader.addEventListener(Event.COMPLETE,loadCom);
			_url=$txtUrl;
			super("TxtContainer");
		}
		override public function onCreate():void
		{
			// TODO Auto Generated method stub
			super.onCreate();
			loader.load(new URLRequest(_url));
		}
		protected function loadCom(event:Event):void
		{
			// TODO Auto-generated method stub
			loader.removeEventListener(Event.COMPLETE,loadCom);
			textView.embedFonts=true;
			textView.wordWrap=true;
			textView.multiline=true;
			textView.selectable=false;
			textView.autoSize=TextFieldAutoSize.LEFT;
			textView.text=event.target.data;
			textView.width=_wid;
//			textView.height=textView.textHeight+5;
			if(textView.height>_heg-20){
				this.dispatchEvent(new Event("ShowBar"));
			}
			textContainer=new VScrollControl(_wid,_heg-20);
			addChild(textContainer);
			textContainer.showupdown=true;
			textContainer.addCell(textView);
			textContainer.x=0;
			textContainer.y=10;
			loader=null;
		}
		
		public function roll(param0:Number):void
		{
			// TODO Auto Generated method stub
			textContainer.move(param0);
		}
	}
}