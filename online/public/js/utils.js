/**
 * @infor util
 * @path  ./js/utils.js
 */

/**
 * Get address bar parameters
 * @param  {string} name 
 * @return {string}      
 */
function getQueryString(name){
  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");   
  var r = window.location.search.substr(1).match(reg);   
  if (r != null) return decodeURI(r[2]); return null; 
}

/**
 * tooltip
 * @param  {string}   msg      
 * @param  {Function} callback 
 * @return void
 */
function tipMsg(msg,callback){
	$('#iosDialog').fadeIn(200);
	$("#iosDialog .weui-dialog__bd").html(msg);
	$("#iosDialog .weui-dialog__btn").click(function(){
		if(!callback)
			$('#iosDialog').fadeOut(200);
		callback();
	})
}