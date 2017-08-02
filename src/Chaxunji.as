package
{
	import com.bit101.components.HScrollBar;
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.king.component.ImgContainer;
	import com.king.component.SkinButton;
	
	import flash.display.Bitmap;
	import flash.text.TextFormat;

	public class Chaxunji extends MainView
	{
		[Embed(source="assets/一级按钮.png")]
		private var UpSkin:Class;
		[Embed(source="assets/二级按钮.png")]
		private var DownSkin:Class;
		public function Chaxunji()
		{
			var img:ImgContainer=new ImgContainer("assets/一级按钮.png");
			this.addChild(img);
		}
	}
}