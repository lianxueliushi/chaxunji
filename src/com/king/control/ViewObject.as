package com.king.control
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * 一个拥有2个状态的sprite 
	 * 在被添加的时候，onCreate();
	 * 在被移除的时候，onDispose();
	 * 
	 * @author Administrator
	 * 
	 */	
	public class ViewObject extends Sprite implements KingObject
	{
		private var _listeners:Array=[];
		private var _myname:String;
		public function ViewObject($name:String="ViewObject")
		{
			super();
			_myname=$name;
			this.addEventListener(Event.ADDED_TO_STAGE,addedToView);
		}
		
		public function addChildByPosition($child:DisplayObject,$x:Number,$y:Number):void{
			this.addChild($child);
			$child.x=int($x);
			$child.y=int($y);
		}
		
		protected function addedToView(event:Event):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(Event.ADDED_TO_STAGE,addedToView);
			this.addEventListener(Event.REMOVED_FROM_STAGE,removeFromView);
			onCreate();
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			// TODO Auto Generated method stub
			_listeners.push({type:type,listener:listener});
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		protected function removeFromView(event:Event):void
		{
			// TODO Auto-generated method stub
			this.removeEventListener(Event.REMOVED_FROM_STAGE,removeFromView);
			onDispose();
		}
		
		public function onCreate():void
		{
			// TODO Auto Generated method stub
//			trace(this.myname+"被创建");
		}
		public function onDispose():void
		{
			// TODO Auto Generated method stub
			while(_listeners.length>0){
				var listener:Object=_listeners.pop();
				removeEventListener(listener.type,listener.listener);
			}
			var leg:int=this.numChildren;
			for (var i:int = 0; i < leg; i++) 
			{
				try
				{
					var child:*=this.removeChildAt(0);
					trace("onDispose:"+child.name);
					if(child is ViewObject){
						child.onDispose();
					}
					else if(child is Bitmap){
						(child as Bitmap).bitmapData.dispose();
					}
					else if(child is Loader){
						(child as Loader).unloadAndStop();
					}
					else if(child is MovieClip){
						(child as MovieClip).stopAllMovieClips();
					}
					child=null;
				} 
				catch(error:Error) 
				{
					trace("移除子对象错误！"+child+error)
				}
			}
			this.graphics.clear();
			trace(this.myname+"被销毁:");
		}

		public function get myname():String
		{
			return _myname;
		}

	}
}