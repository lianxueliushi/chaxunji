package
{
	import com.king.component.VideoContainer;
	import com.king.control.BgMusicControl;
	import com.king.control.KingView;
	import com.king.control.Navigator;
	import com.king.dispatchers.KingDispatcher;
	import com.king.events.NavigatorEvent;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	public class MainView extends KingView
	{
		private var backTimer:Timer;
		public function MainView($add:Boolean=true, $name:String="MainView")
		{
			super($add, $name);
		}
		
		protected function onPass(event:Event):void
		{
			// TODO Auto-generated method stub
			Data.stageWidth=stage.stageWidth;
			Data.stageHeight=stage.stageHeight;
			backTimer=new Timer(Data.backTime,1);
			backTimer.addEventListener(TimerEvent.TIMER_COMPLETE,timeComplete);
			backTimer.start();
			stage.addEventListener(KeyboardEvent.KEY_UP,showMouse);
			KingDispatcher.getInstance().addEventListener(NavigatorEvent.ADD_VIEW,addView);
			KingDispatcher.getInstance().addEventListener(NavigatorEvent.REMOVE_VIEW,removeView);
			KingDispatcher.getInstance().addEventListener(NavigatorEvent.BACK_VIEW,timeComplete);
			stage.addEventListener(MouseEvent.CLICK,onStageClick);
			BgMusicControl.getInstance().source=Data.bgMusicUrl;
			BgMusicControl.getInstance().volume=Data.bgMusicVolume;
			this.addChild(Navigator.getInstance());
		}
		
		override protected function onInit():void
		{
			// TODO Auto Generated method stub
			Mouse.hide();
			var pwd:UsePWD=new UsePWD();
			this.addChild(pwd);
			pwd.addEventListener("onCreate",onPass);
			pwd.beginCheck();
		}
		
		
		protected function onStageClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			resetTimer();
		}
		
		protected function removeView(event:Event):void
		{
			// TODO Auto-generated method stub
			Navigator.getInstance().removeView();
		}
		
		protected function timeComplete(event:TimerEvent=null):void
		{
			// 计时结束回到默认页面
			backTimer.stop();
			if(Navigator.getInstance().latestView is VideoContainer){
				resetTimer();
				return ;
			}
			Navigator.getInstance().back();
		}
		
		protected function showMouse(event:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			if(event.keyCode==Keyboard.ALTERNATE && event.ctrlKey){
				Mouse.show();
			}
			backTimer.reset();
			backTimer.start();
		}
		private function resetTimer():void{
			backTimer.reset();
			backTimer.start();
		}
		protected function addView(event:NavigatorEvent):void
		{
			// 具体方法由子类实现
			
		}
	}
}