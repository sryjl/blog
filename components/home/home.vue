<template>
	<view>
		<el-card class="box-card-call">
			<image src="../../static/cll.png" mode="aspectFit" class="cll"></image>
			<text>欢迎来到我的博客做客，我会分享一些自己心得体会，欢迎留言!</text>
		</el-card>
		<!-- 博客文章内容 -->
		<view class="box-card-father">
			<el-card class="box-card" v-for="(item,index) in blogList" :key='item.id'>
				<image v-if="item.firstPicture" :src="item.firstPicture" mode="aspectFill"></image>
				<image v-else src="../../static/biaotou.png" mode="aspectFill"></image>
				<view class="title-all">
					<text class="title"  @click="toArticle(item.id)">{{item.title}}</uni-title></text>
					<text class="flag" v-show="item.flag">{{item.flag}}</text>
					<text class="recommend" v-show="item.recommend">推荐</text>
				</view>
				<text class="description">{{item.description}}</text>
				<view class="creater">
					<text class="time el-icon-alarm-clock">{{item.createTime.split('T')[0]}}</text>
					<text class="el-icon-user-solid artist">{{nickname}}</text>
					<text class="iconfont icon-guidang artist" @click="gotoClass(item.type.id)" style="cursor: pointer;">{{item.type.name?item.type.name:'暂无分类'}}</text>
					<text class="iconfont icon-biaoqian artist" v-if="item.tags.length>0">
						<text v-for="item1 in item.tags" :key="item1.id" style="display: inline-block;margin-right: 2px;cursor: pointer;" @click="gotoTags(item1.id)">{{item1.name}}</text>
					</text>
					<text class="iconfont icon-biaoqian artist" v-else>暂无标签</text>
				</view>
				<view class="others">
					<text class="el-icon-star-on others-child" v-if="item.appreciation"></text>
					<text class="el-icon-star-off others-child " v-else></text>
					<text class="el-icon-view others-child " space="ensp">{{' '+item.views}}</text>
				</view>
	
			</el-card>
			<!-- 自我展示 -->
			<el-card class="personal">
				<image src="../../static/role.jpg" mode="aspectFit" class="cll"></image>
				<text class="personalqiu">{{nickname}}</text>
				<text>一枚Java渣 但行好事 莫问前程</text>
				<text class="iconfont icon-feiji">江苏-盐城</text>
			</el-card> <!-- 分页 -->
			<el-card class="tags">
				<text class="tagscloud iconfont icon-biaoqian">标签云</text>
				<text v-for="(item,index) in tags" :key="item.id" class="tagsname" @click="gotoTags(item.id)">{{item.name}}</text>
			</el-card> <!-- 分页 -->
			<el-card class="hotdetails">
				<text class="hotblg">热门文章</text>
				<text v-for="(item,index) in hotdetails" :key="item.id" class="hotname" @click="toArticle(item.id)" style="cursor: pointer;"><text :class="{hotindex:true,secondfor:index<2?true:false}">{{index + 1}}</text>{{item.title}}</text>
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
				userid:'',
				nickname:'',
				count: 0,
				tags: [],
				hotdetails: [],
				title: 'Hello',
				blogList: [],
			}
		},
		methods: {
			gotoTags(e){
				this.$router.push(
				{path: '/index/tags', query: {id: e}}
				)
			},
			gotoClass(e){
				this.$router.push(
				{path: '/index/class', query: {id: e}}
				)
			},
			toArticle(e){
				this.$router.push(
				{path: '/index/articledetal', query: {id: e}}
				)
			},
			async getdetail(val) {
				const res = await this.$http({
					url: '/blogPage?pageNumber=' + val+'&userId='+this.userid,
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
					url: '/tags?userId='+this.userid
				})
				this.tags = res.data.data.tags


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
			this.userid=sessionStorage.getItem('id')
			this.nickname =sessionStorage.getItem('nickname')
			console.log(this.userid)
			console.log(this.nickname)
			this.getdetail(0)
			this.gettags()
			this.gethots()
		},

	}
</script>

<style lang="less">
	.title:hover{
		color: orange;
	}
	.liubai{
		height: 40px;
	}
	.Paginational {
		width: 750px;
		margin-top: 30px;
		text-align: center;
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
			margin-right: 30px;
		}

		.artist {
			font-size: 12rpx;
			margin-right: 40px;
		}
	}

	.description {
		position: absolute;
		top: 60px;
		color: #808080;
		left: 240px;
		width: 490px;
		font-size: 14px;
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

		.title {
			display: inline-block;
			overflow: hidden;
			text-overflow: ellipsis;
			max-width: 70%;
			font-size: 18px;
			font-weight: bold;
			vertical-align: middle;
			cursor: pointer;
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
		top: 740px;
		left: 780px;
		.hotblg{
			display:block;
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
   .tags{
	   position: absolute;
	   width: 368px;
	   height: 300px;
	   top: 420px;
	   left: 780px;
	   .tagscloud{
		   display: block;
		   color: #007AFF !important;
		   width: 100%;
		   padding-bottom: 10px;
		   border-bottom: 1px solid #808080;
	   }
	   .tagsname{
		   display: inline-block;
		   padding: 10px;
		   font-size: 20px;
		   font-weight: bold;
		   cursor: pointer;
	   }
	   .tagsname:nth-child(4n+1){
		   color: red;
	   }
	   .tagsname:nth-child(4n+2){
	   		   color: blue;
	   }
	   .tagsname:nth-child(4n+3){
	   		   color: purple;
	   }
	   .tagsname:nth-child(4n+4){
	   		   color: green;
	   }
   }
	.personal {
		position: absolute;
		width: 368px;
		height: 400px;
		top: 0;
		left: 780px;

		image {
			height: 170px;
			width: 170px;
			margin-left: 79px;
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

		.personalqiu {
			font-size: 20px;
			font-weight: bold;
			margin-bottom: 20px;
		}

		.icon-feiji {
			padding-bottom: 20px;
			border-bottom: 1px solid #808080;
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

	.box-card-call {
		position: relative;
		width: 1150px;
		margin: auto;
		margin-top: 30px;
		height: 40px;

		.cll {
			display: block;
			position: absolute;
			top: 10px;
			left: 10px;
			width: 20px;
			height: 20px;
		}

		text {
			display: block;
			position: absolute;
			top: 0;
			left: 50px;
			z-index: 1;
			font-size: 14px;
			color: #808080;
			height: 40px;
			line-height: 40px;
		}
	}



</style>
