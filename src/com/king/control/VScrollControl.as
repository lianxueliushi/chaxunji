﻿package com.king.control
{
	import com.greensock.TweenLite;
	import com.king.events.MyEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import ui.UDbtn;
	
	public class VScrollControl extends ViewObject
	{
		public var _rongqi:ViewObject;
		protected var _mask:Sprite = null;
		private var _y:Number = 0;
		private var _touchPointObj:Object = null;
		protected var _cellArray:Array;
		private var _isDown:Boolean;
		private var _downX:Number=0;
		private var _downY:Number=0;
		private var _scrollBar:Sprite;
		private var _showBar:Boolean;
		private var _barbg:Sprite;
		private var udBtn:MovieClip;
		public static const CELL_CLICK:String="VCellClick";
		public static const DragEndToBottom:String="DragendtoBottom";
		public function VScrollControl($wid:int,$heg:int,$showBar:Boolean=false)
		{
			_mask=creationMask(0,0,$wid,$heg);
			showBar=$showBar;
			super("VScrollControl");
		}
		
		public function set showBar(value:Boolean):void
		{
			_showBar = value;
			if(value){
				_barbg=new Sprite();
				_barbg.graphics.beginFill(0xc2c1c1,1);
				_barbg.graphics.drawRoundRect(0,0,8,_mask.height,10);
				_barbg.graphics.endFill();
				this.addChild(_barbg);
				_barbg.x=_mask.width-20;
				_scrollBar=new Sprite();
				drawScrollbar(20);
				_barbg.addChild(_scrollBar);
				_scrollBar.x=0;
			}else{
				if(_barbg) _barbg.graphics.clear();
				if(_scrollBar) _scrollBar.graphics.clear();
			}
		}
		
		public function get cellArray():Array
		{
			return _cellArray;
		}
		public function move($n:Number):void{
			_y+=$n;
			moveEndSetRongqi();
		}
		public function update():void
		{
			_rongqi.y=0;
		}
		public function addCell(display:DisplayObject,_x:Number=-1,_y:Number=-1):void
		{
			_cellArray.push(display);
			if(_x!=-1){
				display.x=_x;
				if(_cellArray.length==1){
					//					_mask.x=display.x;
				}
			}
			if(_y!=-1){
				display.y=_y;
				if(_cellArray.length==1){
					//					_mask.y=display.y;
				}
			}else{
				display.y = _rongqi.height;
			}
			
			_rongqi.addChild(display);
			moveEndSetRongqi();
		}
		public function removeCell(display:DisplayObject):void
		{
			var len:Number = 0;
			for (var i:int=0; i<_cellArray.length; i++)
			{
				if (display==_cellArray[i])
				{
					len = display.height;
					_rongqi.removeChild(display);
					_cellArray.splice(i,1);
					i--;
				}
				else
				{
					_cellArray[i].y -=  len;
					trace(_cellArray[i].y);
				}
			}
			
			
		}
		public function removeAll():void{
			var len:Number = 0;
			for (var i:int=0; i<_cellArray.length; i++)
			{
				var display:DisplayObject=_cellArray[i];
				len = display.height;
				_rongqi.removeChild(display);
				_cellArray.splice(i,1);
				i--;
				
			}
		}
		public function removeIndexCell(index:int):void
		{
			var len:Number = 0;
			if (index>=_cellArray.length)
			{
				return;
			}
			var display:DisplayObject = _cellArray[index];
			len = display.height;
			_rongqi.removeChild(display);
			_cellArray.splice(index,1);
			for (var i:int=index; i<_cellArray.length; i++)
			{
				_cellArray[i].y -=  len;
				
			}
		}
		private function drawScrollbar($heg:Number):void{
			_scrollBar.graphics.clear();
			_scrollBar.graphics.beginFill(0x969594,1);
			_scrollBar.graphics.drawRoundRect(0,0,8,$heg,10);
			_scrollBar.graphics.endFill();
		}
		override public function onCreate():void{
			_cellArray=[];
			_rongqi=new ViewObject();
			this.addChild(_rongqi);
			_rongqi.x=_mask.x;
			this.addChild(_mask);
			_rongqi.mask = _mask;
			_rongqi.addEventListener(MouseEvent.MOUSE_DOWN,touchDown);
			_rongqi.addEventListener(MouseEvent.MOUSE_UP,touchEnd);
			_rongqi.addEventListener(MouseEvent.MOUSE_MOVE,touchMove);
			_rongqi.addEventListener(MouseEvent.ROLL_OUT,touchEnd);
			super.onCreate();
		}
		public function set updownBtn($value:MovieClip):void{
			if($value){
				udBtn=$value;
				this.addChild(udBtn);
				udBtn.x=_mask.width-20;
				udBtn.y=_mask.height-40;
				udBtn.btn_up.addEventListener(MouseEvent.CLICK,onUp);
				udBtn.btn_down.addEventListener(MouseEvent.CLICK,onDown);
				udBtn.visible=true;
			}
		}
		public function set showupdown($value:Boolean):void{
			if($value){
				if(udBtn==null){
					udBtn=new UDbtn();
					this.addChild(udBtn);
					udBtn.x=_mask.width-20;
					udBtn.y=_mask.height-40;
					udBtn.btn_up.addEventListener(MouseEvent.CLICK,onUp);
					udBtn.btn_down.addEventListener(MouseEvent.CLICK,onDown);
				}
				else udBtn.visible=true;
			}
			else{
				if(udBtn!=null) udBtn.visible=false;
			}
		}
		protected function onUp(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			_y+=50;
			moveEndSetRongqi();
		}
		protected function onDown(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			_y-=50;
			moveEndSetRongqi();
		}
		
		override public function onDispose():void
		{
			// TODO Auto Generated method stub
			removeAll();
			_cellArray=[];
			/*_mask.graphics.clear();
			if(_rongqi) removeChild(_rongqi);
			removeChild(_mask);
			if(_showBar && _scrollBar){
				_barbg.graphics.clear();
				removeChild(_barbg);
				_scrollBar.graphics.clear();
				removeChild(_scrollBar);
			}*/
			super.onDispose();
		}
		private function creationMask(xi:Number,yi:Number,widthi:Number,heighti:Number):Sprite
		{
			var sp:Sprite=new Sprite();
			sp.graphics.beginFill(0);
			sp.graphics.drawRoundRect(xi,yi,widthi,heighti,5,5);
			sp.graphics.endFill();
			return sp;
		}
		private function touchDown(e:MouseEvent):void
		{
			_isDown=true;
			if (_touchPointObj!=null)
			{
				_touchPointObj=null;
			}
			_touchPointObj=new Object();
			_y = _rongqi.y;
			_touchPointObj.stagey = e.stageY;
			_touchPointObj.stagex=e.stageX;
			_touchPointObj.move = 0;
			
			_downX=e.stageX;
			_downY=e.stageY;
		}
		
		private function touchMove(e:MouseEvent):void
		{
			if(!_isDown){
				return ;
			}
			_touchPointObj.move = e.stageY - _touchPointObj.stagey;
			_y += _touchPointObj.move;
			_touchPointObj.stagey = e.stageY;
			_touchPointObj.stagex=e.stageX;
			TweenLite.to(_rongqi,0.6,{y:_y});
			
		}
		private function touchEnd(e:MouseEvent):void
		{
			if(_isDown){
				if(Math.abs(_downY-e.stageY)<=5 && Math.abs(_downX-e.stageX)<=5){
					for(var i:int=0;i<_cellArray.length;i++){
						var tg:DisplayObjectContainer=cellArray[i] as DisplayObjectContainer;
						if(tg){
							if(tg.contains(e.target as DisplayObject)){
								this.dispatchEvent(new MyEvent(VScrollControl.CELL_CLICK,_cellArray[i]));
								break ;
							}
						}
					}
				}
				_y +=  _touchPointObj.move * 10;//_touchPointObj.move 是移动速度
				moveEndSetRongqi();
				_isDown=false;
				_touchPointObj = null;
			}
			
		}
		
		protected function moveEndSetRongqi():void
		{  
			if (_rongqi.height <= _mask.height)
			{
				if(udBtn) udBtn.visible=false;
				if (_y<_mask.y)
				{
					_y = _mask.y;
				}
				else if (_y>_mask.y)
				{
					_y = 0;
					
				}
			}
			else
			{
				if(udBtn){
					udBtn.visible=true;
					udBtn.x=_mask.width-10;
					udBtn.y=_mask.height-45;
				}
				if (_y>_mask.y)
				{
					_y = _mask.y;
				}
				else if (_y<_mask.y+_mask.height-_rongqi.height)
				{
					_y = _mask.y + _mask.height - _rongqi.height;
					this.dispatchEvent(new MyEvent(VScrollControl.DragEndToBottom));//拖动到最底端触发事件
				}
			}
			if(_scrollBar){
				_barbg.visible=_showBar;
				var heg:Number=_mask.height*_mask.height/_rongqi.height;
				drawScrollbar(heg);
				var barendY:Number=(-_y*_mask.height)/_rongqi.height;
				if(barendY>=_mask.height-_scrollBar.height){
					barendY=_mask.height-_scrollBar.height;
				}
				if(barendY<0){
					barendY=0;
				}
				TweenLite.to(_scrollBar,0.6,{y:barendY});
			}
			var num:Number=_y-_rongqi.y;
			TweenLite.to(_rongqi,0.6,{y:_y,onComplete:tweenCom,onCompleteParams:[num]});
		}
		protected function tweenCom(abs:Number):void
		{
			
			
		}
		
		
		
	}
	
}