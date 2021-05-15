<script>
	
	export default {
		// 引入线性颗粒
		onLaunch: function() {
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		},
	}
</script>

<style>
	/*每个页面公共css */	
	@import url("./static/fonts/iconfont.css");
	@import url("./element-ui/lib/theme-chalk/index.css");
	@import url("./static/editor.css");
	page{
			background-image: url(https://yssimage.oss-cn-hangzhou.aliyuncs.com/11.jpg);
			background-size:100%;
			 background-attachment: fixed;
		}
</style>
