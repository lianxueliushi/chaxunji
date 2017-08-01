package
{
	import com.king.control.KingView;
	import com.king.control.Navigator;
	import com.king.dispatchers.KingDispatcher;
	import com.king.events.NavigatorEvent;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.media.Video;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	public class MainView extends KingView
	{
		private var backTimer:Timer;
		public function MainView($add:Boolean=true, $name:String="MainView")
		{
			super($add, $name);
			Mouse.hide();
			backTimer=new Timer(Data.backTime,1);
			backTimer.addEventListener(TimerEvent.TIMER_COMPLETE,timeComplete);
			backTimer.start();
			stage.addEventListener(KeyboardEvent.KEY_UP,showMouse);
			KingDispatcher.getInstance().addEventListener(NavigatorEvent.ADD_VIEW,addView);
		}
		
		protected function timeComplete(event:TimerEvent):void
		{
			// 计时结束回到默认页面
			backTimer.stop();
			if(Navigator.getInstance().latestView is VideoControl){
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
		protected function addView(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
	}
}