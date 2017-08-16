package com.king.component
{
	import com.king.control.Navigator;
	
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	public class PictureTranstionForPreview extends PictureTransition
	{
		public function PictureTranstionForPreview($wid:Number, $heg:Number,$imgFileList:Array, $currFile:File=null, $name:String="Component_PictureTransition")
		{
			var leftBtn:UI_btnLeft=new UI_btnLeft();
			var rightBtn:UI_btnLeft=new UI_btnLeft();
			super($wid, $heg,$imgFileList,leftBtn, rightBtn, $currFile, $name);
		}
		
		override protected function onImgClick(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			this.mouseChildren=false;
			this.mouseEnabled=false;
			Navigator.getInstance().removeView();
		}
		
		
	}
}