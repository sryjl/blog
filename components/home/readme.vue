<template>
	<view>
		<el-card class="personal">
				<image src="../../static/role.jpg" mode="aspectFit" class="cll"></image>
				<text class="personalqiu">秋人</text>
				<text class="describe">一枚Java渣 但行好事 莫问前程</text>
				<text class="iconfont icon-feiji">江苏-盐城</text>
				<text style="font-size: 22px;color: #808080;">简介</text>
				<text style="font-size: 14px;">秋人，98年，创建本站是因为偶然看到别人的博客网站做的不错，自己也做一个练手，同时总结记录学习经验。</text>
		        <view style="margin-left: 40px;margin-top: 40px;font-weight: bold;">个人信息</view>
				<view style="margin-left: 70px;margin-top: 10px;font-weight: 400; font-size: 14px;">出生于盐城，暂居南通，21年毕业，学渣一枚。</view>
				<view style="margin-left: 40px;margin-top: 40px;font-weight: bold;">个人介绍</view>
				<view style="margin-left: 70px;margin-top: 10px;font-weight: 400; font-size: 14px;">
					一个喜欢旅游，喜欢在路上的感觉！喜欢电子音乐的男同学~(偶尔会跟大家分享一些好听的电子音乐，在本站我也会推荐，喜欢的可以关注我的网易云，收藏我自己整理的歌单：大魔王千石)					
					</view>
					<text style="font-weight: bold;font-size: 14px;">End</text>
		</el-card> <!-- 分页 -->
		<view style="height: 40px;width: 100%;">
			
		</view>
	</view>
</template>

<script>
	export default{
	data(){
				return{
					userid:'',
					nickname:'',
					blogList:[]
					}
			},
			methods:{
				async getDocument(){
					// this.active = e
					const res =await this.$http({
						url:'/seeAboutMe/'+this.userid
					})
					console.log(res)
				},
			},
			created() {
				this.userid=sessionStorage.getItem('id')
				this.nickname =sessionStorage.getItem('nickname')
				this.getDocument()
			}
		}
</script>

<style lang="less">
	.personal {
		width: 60%;
		margin: auto;
		margin-top: 40px;
		left: 780px;
	
		image {
			height: 250px;
			width: 250px;
			margin: auto;
			margin-top: 10px;
			border-radius: 50%;
			display: block;
		}
	
		text {
			display: block;
			width: 100%;
			margin-top: 20px;
			text-align: center;
		}
		.describe{
			font-family: "Helvetica Neue", Helvetica, "PingFang SC", Tahoma, Arial, sans-serif;
			color: #444;
			font-size: 18px;
		}
	
		.personalqiu {
			font-size: 24px;
			font-weight: bold;
			margin-bottom: 20px;
		}
	
		.icon-feiji {
			padding-bottom: 20px;
			border-bottom: 1px solid #808080;
		}
	
	}
</style>
