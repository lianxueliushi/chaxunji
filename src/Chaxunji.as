package
{
	import com.king.component.PictureTransition;
	import com.king.component.TxtContainer;
	import com.king.control.FileControl;
	import com.king.control.Navigator;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	

	[SWF(width="1920",height="1080")]
	public class Chaxunji extends MainView
	{
		private var i:int;
		private var imgList:Array=[];
		private var urlList:Array=[];
		public function Chaxunji()
		{
			super();
			
		}
		override protected function oninit(event:Event):void
		{
			// TODO Auto Generated method stub
			super.oninit(event);
			imgList=FileControl.getImgFileDirs("assets/");
			var leftBtn:UI_btnLeft=new UI_btnLeft();
			var rightBtn:UI_btnLeft=new UI_btnLeft();
			var pics:PictureTransition=new PictureTransition(600,400,imgList,leftBtn,rightBtn);
			Navigator.getInstance().addChild(pics);
			var txt:TxtContainer=new TxtContainer(500,400,"assets/44.txt");
			Navigator.getInstance().addChild(txt);
			setTimeout(remove,3000);
			
			function remove():void{
				Navigator.getInstance().removeChild(pics);
			}
			
		}
		
		
	}
}