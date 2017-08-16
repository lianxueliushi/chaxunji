package com.king.views
{
	import com.greensock.TweenLite;
	import com.king.component.PictureTranstionForPreview;
	import com.king.control.KingView;
	
	import flash.filesystem.File;
	
	public class View_previewImg extends KingView
	{
		private var mypics:PictureTranstionForPreview;
		public function View_previewImg($file:File,$fileList:Array,$add:Boolean=true, $name:String="KingView")
		{
			mypics=new PictureTranstionForPreview(Data.stageWidth-200,Data.stageHeight-100,$fileList,$file);
			mypics.x=100;
			mypics.y=50;
			super($add, $name);
			this.addChild(mypics);
			this.setbgColor(0x000000,0.8);
			_bg.alpha=1;
			TweenLite.from(_bg,0.3,{alpha:0,delay:0.3});
		}
	}
}