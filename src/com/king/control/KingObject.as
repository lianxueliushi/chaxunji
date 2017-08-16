package com.king.control
{
	/**
	* @author Administrator
	*/
	public interface KingObject
	{
		/**
		 *一个物体，拥有创建，开始运行，暂停运行，销毁 四个状态
		 * @param target
		 * 
		 */		
		function onCreate():void;
		function onDispose():void;
	}
}