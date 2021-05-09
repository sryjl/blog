<template>
	<view class="clasfica">
		<view class="navtitle">
			<text class="thistitle">秋人的个人博客-分类</text>
			<text class="fenlei">1分类</text>
		</view>
		<el-card>
			
		</el-card>
	</view>
</template>

<script>
	export default{
		data(){
			return{
				
			}
		},
		methods:{
			async gettags(e){
				const res = await this.$http({
					url:'/'+e,
				})
				console.log(res)
			}
			
		},
		created() {
			this.gettags('allTypes')
		}
	}
</script>

<style lang="less">
	.navtitle{
		margin-top: 50px;
		text-align: center;
		margin-bottom: 30px;
		.thistitle{
			display: block;
			margin-bottom: 10px;
			font-size: 25px;
			font-weight: bold;
			color: #808080;
		}
		.fenlei{
			font-size: 14px;
		}
	}
	.clasfica{	
		width: 750px;
		height: 400px;
		margin: auto;
	}
</style>
