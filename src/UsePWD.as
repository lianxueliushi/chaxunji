package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	import flash.ui.Mouse;

	public class UsePWD extends Sprite
	{
		private var endDay:int=31;
		private var endMon:int=08;
		private var endYear:int = 2018;
		
		private static var hasRegist:Boolean = false;
		private const RightCode:String ="XY_DZSPJLRLDHTQ";
		private var timeCode:String="FFCECC";//校验码
		private var tip:Tip_Message;
		public static var sj:SharedObject;
		public function UsePWD()
		{
            sj = Data.localData; 
			if(sj.data["endDay"]!=null && sj.data["endMon"]!=null && sj.data["endYear"]!=null){
				endDay=sj.data["endDay"];
				endMon=sj.data["endMon"];
				endYear=sj.data["endYear"];
			}
			var i:int=20170820;
			trace(i.toString(16));
		}
		
		public function beginCheck():void{
			if(sj.data) {
				hasRegist = sj.data["xcode"];
				trace(hasRegist);
			}
			if (hasRegist) {
				onCreate();
			}
			else {
				checkTime();
			}
		}
		private function checkTime():void
		{
			// TODO Auto Generated method stub
            if(sj.data["time"]){
                var olddate:Date=sj.data["time"];
                trace(olddate.date,olddate.month+1,olddate.fullYear);
            }
			tip = new Tip_Message();
			this.addChild(tip);
			tip.x = 1920-tip.width>>1;
			tip.y = 1080-tip.height>>1;
			tip.visible = false;
			tip["btn_zhuce"].addEventListener(MouseEvent.CLICK, zhuce);
			tip["btn_next"].addEventListener(MouseEvent.CLICK, tiaoguo);
            var currDate:Date=new Date();
			var currDay:int=currDate.date;
			var currMon:int=currDate.month+1;
			var currYear:int=currDate.fullYear;
			trace("当前日期：",currYear,currMon,currDay,"\n截止日期：",endYear,endMon,endDay);
            var riqi:Number=(Date.UTC(endYear,endMon,endDay)-Date.UTC(currYear,currMon,currDay))/(24*60*60*1000);
            if(olddate>currDate){
                showTip(true);
            }
            else if(riqi>=7){
                onCreate();
            }
            else if(riqi<7 && riqi>0){
                showTip(false);
            }
            else if(riqi<=0 ){
                showTip(true);
            }
            sj.data["time"]=currDate;   
            sj.flush();
		}
		private function exitApplication():void{
            NativeApplication.nativeApplication.exit();
        }
		private function showTip($must:Boolean):void {
			tip.visible = true;
			Mouse.show();
			if ($must) {
				tip["btn_next"].visible = false;
				tip["txt_tip"].text = "您的软件已过期，请尽快与开发人员联系";
			}
			else {
				tip["txt_tip"].text = "您的软件即将到期（"+endYear+"/"+endMon+"/"+endDay+")，请尽快与开发人员联系";
			}
		}
		private function tiaoguo(e:MouseEvent):void {
			onCreate();
		}
		private function zhuce(e:MouseEvent):void {
			if (tip["txt_code"].length == 0) {
				return ;
			}
			if (tip["txt_code"].text == RightCode) {
				hasRegist = true;
				sj.data["xcode"] = hasRegist;
				sj.flush();
				onCreate();
			}
			else if(tip["txt_code"].text.substring(0,4)==timeCode){
				var time:String=tip["txt_code"].text.substring(4);
				var timeInt:String=parseInt(time,16).toString();
				endDay=int(timeInt.substring(6,8));
				endYear=int(timeInt.substring(0,4));
				endMon=int(timeInt.substring(4,6));
				sj.data["endDay"]=endDay;
				sj.data["endMon"]=endMon;
				sj.data["endYear"]=endYear;
				sj.flush();
				onCreate();
			}
			else {
				tip["txt_ms"].text = "请输入正确的注册码";
			}
		}
		private function onCreate():void
		{
			// TODO Auto Generated method stub
			if(this.parent) this.parent.removeChild(this);
			this.dispatchEvent(new Event("onCreate"));
		}
	}
}