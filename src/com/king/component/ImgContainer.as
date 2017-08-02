package com.king.component
{
	import com.greensock.loading.core.LoaderItem;
	import com.king.control.ViewObject;
	
	import flash.filesystem.File;
	
	public class ImgContainer extends ViewObject
	{
		private var _url:String;
		private var _source:File;
		private var _loader:LoaderItem;
		public function ImgContainer($url:String,$name:String="ImgContainer")
		{
			super($name);
			_url=$url;
			if(_url.length>0){
				_source=new File(_url);
				if(_source.exists){
					if(_source.extension.toLowerCase()=="flv" || _source.extension.toLowerCase()=="mp4"){
						
					}
				}
			}
		}
	}
}