<template>
	<view>
		<!-- 博客文章内容 -->
		<view class="box-card-father">
			<el-card class="box-card" v-for="(item,index) in blogList" :key='item.id'>
				<image v-if="item.firstPicture" :src="item.firstPicture" mode="aspectFill"></image>
				<image v-else src="../../static/biaotou.png" mode="aspectFill"></image>
				<view class="title-all" @click="toArticle(item.id)">
					<text class="title">{{item.title}}</uni-title></text>
					<text class="flag" v-show="item.flag">{{item.flag}}</text>
					<text class="recommend" v-show="item.recommend">推荐</text>
				</view>
				<text class="description">{{item.description}}</text>
				<view class="creater">
					<text class="time el-icon-alarm-clock">2020/12/22</text>
					<text class="el-icon-user-solid artist">秋人</text>
					<text class="iconfont icon-guidang artist">归档占位</text>
					<text class="iconfont icon-biaoqian artist">标签占位</text>
				</view>
				<view class="others">
					<text class="el-icon-star-on others-child" v-if="item.appreciation"></text>
					<text class="el-icon-star-off others-child " v-else></text>
					<text class="el-icon-view others-child " space="ensp">{{' '+item.views}}</text>
				</view>
	
			</el-card>
			<!-- 搜索框 -->
			<el-card class="search">			
			   <uni-search-bar></uni-search-bar>
			</el-card> <!-- 分页 -->

			<!-- 分类 -->
			<el-card class="tags">
				<text class="tagscloud">分类</text>
				<text v-for="(item,index) in tags" :key="item.id" class="tagsname">{{item.name}}</text>
			</el-card> <!-- 分页 -->
			<el-card class="hotdetails">
				<text class="hotblg">热门文章</text>
				<text v-for="(item,index) in hotdetails" :key="item.id" class="hotname"><text :class="{hotindex:true,secondfor:index<2?true:false}">{{index + 1}}</text>{{item.title}}</text>
			</el-card> <!-- 分页 -->
			<view class="Paginational">
				<el-pagination background  @current-change="handleCurrentChange" @prev-click="handleCurrentChange"
				 @next-click="handleCurrentChange" layout="total,prev, pager, next" :total="count" :page-size="10">
				</el-pagination>
			</view>
			<view class="liubai">
				
			</view>
		</view>
		</view>
</template>

<script>
	export default {
		data() {
			return {
				count: 0,
				tags: [],
				hotdetails: [],
				title: 'Hello',
				blogList: [],
			}
		},
		methods: {
			toArticle(e){
				this.$router.push(
				{path: '/index/articledetal', query: {id: e}}
				)
			},
			async getdetail(val) {
				const res = await this.$http({
					url: '/blogPage/' + val
				})
				this.blogList = res.data.data.blogs
				this.count = res.data.data.count
			},
			handleCurrentChange(e) {
				let val = e - 1
				this.getdetail(val)
			},
			async gettags() {
				const res = await this.$http({
					url: '/types'
				})
				console.log(res)
				this.tags = res.data.data.types

			},
			async gethots() {
				const res = await this.$http({
					url: '/hotBlogs'
				})
				this.hotdetails = res.data.data.hotBlogs

			},
			toLogin(){
				console.log(this.activeIndex2)
				// uni.navigateTo({
				// 	url:'../login/index'
				// })
				this.$router.push("login")
			},
			async getstatus() {
				const res = await this.$http({
					url: '/status'
				})
				this.user = res.data.data
				console.log(this.user)
			},
			async loginout(){
				const res = await this.$http({
					url: '/logout'
				})
				console.log(res)
				if(res.data.code === 200){
					sessionStorage.removeItem('token')
					this.$message.success('已成功退出登录')
					this.islogin =false			
				}else{
					this.$message.error('操作失败')
				}		
			}
			
		},
		created() {
			this.getdetail(0)
			this.gettags()
			this.gethots()
		},

	}
</script>

<style lang="less">
	.Paginational {
		width: 750px;
		margin-top: 30px;
		text-align: center;
	}
	.liubai{
		height: 40px;
	}
	.others {
		position: absolute;
		bottom: 20px;
		right: 20px;
		color: #808080;

		.others-child {
			font-size: 18px;
			margin-right: 20px;
		}

		.el-icon-star-on {
			color: red;
			font-size: 24px;
		}
	}

	.creater {
		position: absolute;
		bottom: 12px;
		color: #808080;

		.time {
			font-size: 12px;
			margin-right: 40px;
		}

		.artist {
			font-size: 12px;
			margin-right: 40px;
		}
	}

	.description {
		position: absolute;
		top: 60px;
		left: 240px;
		width: 490px;
		font-size: 14px;
		color: #808080;
		word-wrap: break-word;
		display: -webkit-box;
		-webkit-box-orient: vertical;
		-webkit-line-clamp: 5;
		overflow: hidden;
		text-overflow: ellipsis;
	}

	.title-all {
		position: absolute;
		top: 20px;
		left: 240px;
		z-index: 2;
		width: 500px;
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
		height: 30px;
		line-height: 30px;
		.title:hover{
			color: orange;
		}
		.title{
			display: inline-block;
			overflow: hidden;
			text-overflow: ellipsis;
			max-width: 70%;
			font-size: 18px;
			font-weight: bold;
			vertical-align: middle;
		}
		.flag {
			border-radius: 5px;
			height: 20px;
			line-height: 20px;
			font-size: 12px;
			padding-left: 5px;
			padding-right: 5px;
			display: inline-block;
			margin-left: 10px;
			margin-right: 10px;
			background-color: #FF0080;
			color: #FFFFFF;
			vertical-align: middle;
		}

		.recommend {
			border-radius: 5px;
			height: 20px;
			line-height: 20px;
			font-size: 12px;
			padding-left: 5px;
			padding-right: 5px;
			display: inline-block;
			margin-right: 10px;
			background-color: #FF4000;
			color: #FFFFFF;
			vertical-align: middle;
		}
	}
	.hotdetails{
		position: absolute;
		width: 368px;
		height: 300px;
		top: 420px;
		left: 780px;
		.hotblg{
			display:block;
			text-align: center;
			font-weight: bold;
			width: 100%;
			color: #007AFF !important;
			padding-bottom: 10px;
			border-bottom: 1px solid #808080;
		}
		.hotname{
			font-size: 16px;
			height: 20px;
			line-height: 20px;
			display: block;
			padding-top: 20px;
			width: 100%;
			overflow: hidden;
			text-overflow: ellipsis;
			.hotindex{
				padding: 3px;
				padding-left: 5px;
				padding-right: 5px;
				margin-right: 5px;
				background-color: #007AFF;
				border-radius: 5px;
			}
			.secondfor{
				background-color: #F56C6C;
			}
		}
	}
	.search{
		position: absolute;
		width: 368px;
		height: 90px;
		top: 0px;
		left: 780px;
	}
	
   .tags{
	   position: absolute;
	   width: 368px;
	   height: 300px;
	   top: 100px;
	   left: 780px;
	   .tagscloud{
		   text-align: center;
		   font-weight: bold;
		   display: block;
		   color: #007AFF !important;
		   width: 100%;
		   padding-bottom: 10px;
		   border-bottom: 1px solid #808080;
	   }
	   .tagsname{
		   display: inline-block;
		   text-align: center;
		   width: 50%;
		   margin: 10px 0;
		   height: 30px;
		   line-height: 30px;
		   color: #808080;
		   background-color: rgba(88,88,88,0.1);
		   border-radius: 20px;
		   font-size: 16px;
		   font-weight: bold;
	   }
   }
	.box-card-father {
		position: relative;
		width: 1150px;
		margin: auto;
		height: 40px;

		.box-card {
			position: relative;
			height: 200px;
			width: 750px;
			margin-top: 10px;

			image {
				margin-top: 5px;
				width: 200px;
				height: 130px;
			}
		}

		.box-card:first-child {
			margin-top: 20px;
		}
	}


</style>

