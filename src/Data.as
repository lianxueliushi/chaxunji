package
{
	import com.king.control.FileControl;
	
	import flash.net.SharedObject;

	public class Data
	{
		public static const backTime:int=5*60*3000;//分钟无人触摸则返回首页
		public static var stageWidth:Number=1920;
		public static var stageHeight:Number=1080;
		public static var localData:SharedObject=SharedObject.getLocal(localname);
		public static var bgMusicVolume:Number=0.3;//背景音乐全局音量
		private static const localname:String="LocalData_King";
		public static var bgMusicUrl:String;
		public static var url:String="d:/项目资料/资料_苏北人民医院/公益责任/";
		private static var _firstFile:String=url;
		private static var _sedFile:String;
		private static var _thirdFile:String;
		private static var _forthFile:String;
		private static var _fifthFile:String;
		private static var _oneSelected:int=0;
		private static var _twoSelected:int=0;
		private static var _threeSelected:int=0;
		private static var _fourSelected:int=0;
		public function Data()
		{
			
		}

		public static function get oneSelected():int
		{
			return _oneSelected;
		}

		public static function set oneSelected(value:int):void
		{
			_oneSelected = value;
			if(_firstFile){
				var temp:Array=FileControl.getDirectorys(_firstFile);
				if(value>temp.length-1){
					throw new Error("索引超标！")
				}
				else _sedFile=temp[value].url;
			}
			else{
				throw new Error("第一级目录还没有指定！")
			}
		}

		public static function get twoSelected():int
		{
			return _twoSelected;
		}

		public static function set twoSelected(value:int):void
		{
			_twoSelected = value;
			if(_sedFile){
				var temp:Array=FileControl.getDirectorys(_sedFile);
				if(value>temp.length-1){
					throw new Error("索引超标！")
				}
				else _thirdFile=temp[value].url;
			}
			else{
				throw new Error("第二级目录还没有指定！")
			}
		}

		public static function get threeSelected():int
		{
			return _threeSelected;
		}

		public static function set threeSelected(value:int):void
		{
			_threeSelected = value;
			if(_thirdFile){
				var temp:Array=FileControl.getDirectorys(_thirdFile);
				if(value>temp.length-1){
					throw new Error("索引超标！")
				}
				else _forthFile=temp[value].url;
			}
			else{
				throw new Error("第三级目录还没有指定！")
			}
		}

		public static function get fourSelected():int
		{
			return _fourSelected;
		}

		public static function set fourSelected(value:int):void
		{
			_fourSelected = value;
			if(_forthFile){
				var temp:Array=FileControl.getDirectorys(_forthFile);
				if(value>temp.length-1){
					throw new Error("索引超标！")
				}
				else _fifthFile=temp[value].url;
			}
			else{
				throw new Error("第四级目录还没有指定！")
			}
		}


	}
}