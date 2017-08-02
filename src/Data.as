package
{
	import flash.net.SharedObject;

	public class Data
	{
		public static const backTime:int=5*60*3000;//分钟无人触摸则返回首页
		public static var stageWidth:Number=1920;
		public static var stageHeight:Number=1080;
		public static var localData:SharedObject;
		public static var bgMusicVolume:Number=0.3;//背景音乐全局音量
		public static const localname:String="LocalData_King";
		public function Data()
		{
			
		}
	}
}