package com.king.control
{
	import com.king.events.PlayEvent;
	
	import flash.net.SharedObject;
	
	import fl.video.FLVPlayback;
	import fl.video.VideoEvent;
	import fl.video.VideoScaleMode;
	
	public class VideoControl extends FLVPlayback
	{
		private var _isloop:Boolean;
		private var videoTimeList:Array=[];
		public static var videoVolume:Number=0.7;//视频全局音量
		public function VideoControl($wid:int,$heg:int,$isloop:Boolean,$getTime:Boolean=false)
		{
			super();
			Data.localData=SharedObject.getLocal(Data.localname);
			if(Data.localData.data["videoVolume"]){
				videoVolume=Data.localData.data["videoVolume"];
			}
			volume=videoVolume;
			_isloop=$isloop;
			autoPlay=true;
			width=$wid;
			height=$heg;
			scaleMode=VideoScaleMode.EXACT_FIT;
			if($getTime){
				this.addEventListener(VideoEvent.PLAYHEAD_UPDATE,playingHandler);
			}
		}
		
		protected function playingHandler(event:VideoEvent):void
		{
			// TODO Auto-generated method stub
			var time:int=Math.floor(this.playheadTime);
			if(videoTimeList.indexOf(time)==-1){
				videoTimeList.push(time);
				this.dispatchEvent(new PlayEvent(PlayEvent.GET_VIDEO_TIME,time));
				if(videoTimeList.length>1){
					videoTimeList.shift();
				}
				if(time==Math.floor(this.totalTime)){
					videoTimeList=[];
				}
			}
		}
		override public function set source(url:String):void
		{
			// TODO Auto Generated method stub
			this.activeVideoPlayerIndex=0;
			this.visibleVideoPlayerIndex=0;
			videoTimeList=[];
			super.source=url;
			if(_isloop){
				this.activeVideoPlayerIndex=1;
				super.source=url;
				this.activeVideoPlayerIndex=0;	
			}
		}
		
		protected function playOver(event:VideoEvent):void
		{
			// TODO Auto-generated method stub
			if(_isloop){
				if(this.activeVideoPlayerIndex==1){
					this.activeVideoPlayerIndex=0;
					this.visibleVideoPlayerIndex=0;
				}
				else{
					this.activeVideoPlayerIndex=1;
					this.visibleVideoPlayerIndex=1;
				}
				volume=videoVolume;
				play();
			}
			else{
				this.dispatchEvent(new PlayEvent(PlayEvent.PLAY_OVER,null));
			}
			
		}
		override public function set volume(vol:Number):void
		{
			// TODO Auto Generated method stub
			Data.localData.data["videoVolume"]=vol;
			Data.localData.flush();
			videoVolume=vol;
			super.volume = vol;
		}
		
		
	}
}