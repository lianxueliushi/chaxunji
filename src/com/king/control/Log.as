package com.king.control
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class Log
	{
		private static var _Message:String="";
		private static var _Path:File = File.documentsDirectory;
		private static var _file:File = _Path.resolvePath("errorDiary.txt");
		public function Log()
		{
		}
		public static function log($mes:String):void{
			trace("[debug:"+$mes+"]");
			_Message+=$mes+"\n";
			saveMessage();
		}
		private static function saveMessage():void{
		
			if(_file.exists){
				_file.deleteFile();
			}
			var fileStream:FileStream = new FileStream(); 
			try
			{
				fileStream.openAsync(_file,FileMode.WRITE); //以WRITE方式打开file, 如果file中对应的文件不存在，创建新文件 
				fileStream.writeUTFBytes(_Message); //像文件中写入内容。
			} 
			catch(error:Error) 
			{
				log("写入错误");
			}
			 
			fileStream.close(); //完成写入
			trace("保存完毕");
		}
	}
}