<template>
	<view>
		<el-card class="content" v-if="thisBlog !== null">
			<!-- 标题 -->
			<view class="title">
				<text>{{thisBlog.title}}</text>
			</view>
			<!-- 发布日期等 -->
			<view class="details" v-if="thisBlog.updateTime">
				<text class="firstchild">发表日期: {{thisBlog.updateTime.split('T')[0]}}</text>
				<text>作者: 秋人</text>
				<text>浏览数: {{thisBlog.views}}</text>
				<text>类型：{{thisBlog.flag}}</text>
			</view>
			
			<view class="artcontent">
				<p>{{thisBlog.content}}</p>
			</view>
			

		</el-card>			
		<view class="comment">
			<el-card>
				<view class="letcomment">
					<el-input
				  type="textarea"
				  :rows="4"
				  :placeholder="islogin?'请输入评论':'请登录后再评论'"
				  v-model="textarea"
				  resize = "none"
				  :disabled ="!thisBlog.commentabled || !islogin || isupdate"
				  maxlength='300'
				  show-word-limit
				  >
				</el-input>
				<view class="elbutton">
					<el-button type="primary" @click="submitcom" :loading="isupdate" :disabled="!thisBlog.commentabled || !islogin || isupdate">提交评论</el-button>
				</view>
				</view>

				<!-- 留言板 -->
				<view class="geliceng">
					
				</view>
				<view class="gocomments" v-if="comments.length > 0">
					<text class="commentnav">评论({{comments.length}})</text>
					<view class="realcomment" v-for="(item,index) in comments" :key = "item.id">
						
						<view class="navlist">
						<image  :src="item.avatar" mode="aspectFit"></image>
						<text class="nickname">{{item.nickname}}</text>
						<text class="createtime">2020/12/25</text>
						</view>

						<text class="realcontent">{{item.content}}</text>
					</view>
				</view>

				<view  v-else class="gocomments">
					<text>暂无评论</text>
				</view>
				<view class="liubai">
					
				</view>
			</el-card>
			<view class="liubai">
				
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				isupdate:false,
				textarea:'',
				id: '',
				thisBlog:{
					commentabled:false
				},
				islogin:false,
				comments:[]
			}
		},
		methods: {
			submitcom(){
				if(this.isupdate) return
				if(this.textarea.trim()===''){
					return this.$message.error({
						duration:1000,
						message:'请输入内容后提交'
					})
				}
				this.isupdate = true
				this.sendcommit()
			},
			async sendcommit(){
				console.log(this.$route.query.id)
				const res = await uni.request({
					url:'/api/say',
					method:'POST',
					data:{
						content:this.textarea,
						blogId:this.$route.query.id
					},
				})
				console.log(res)
				this.isupdate = false
				if(res[1].data.code ===200){
					this.textarea = ''
					this.getcomment()
					return this.$message.success({
						message:'评论成功',
						duration:1000,
					})
				}else{
					return this.$message.error({
						message:'评论失败',
						duration:1000,
					})
				}
			},
			async getblogdetail() {
				const res = await this.$http({
					url: '/thisBlog/' + this.id
				})
				this.thisBlog = res.data.data.thisBlog

			},
			async getcomment(){
				const res1 =await this.$http({
					url:'/comment/' + this.$route.query.id
				})
				this.comments = res1.data.data.comments
			}

		},
		created() {
			this.id = this.$route.query.id
			let login = sessionStorage.getItem('token')
			if(login){
				this.islogin = true
			}
			this.getblogdetail()
			this.getcomment()
		},
	}
</script>

<style lang="less">
	.liubai{
		height: 100px;
	}
	.realcomment{
		margin-top: 30px;
		image{
			height: 30px;
			width: 30px;
			border-radius: 50%;
			vertical-align: middle;
		}
		.navlist{
			text{
				vertical-align: middle;
				margin-left: 10px;
				font-size: 14px;
			}
			.createtime{
				color: #808080;
			}
		}
	    .realcontent{
			display: inline-block;
			width: 950px;
			margin: 0 40px;
			margin-top: 10px;
			
		}
	}
	.gocomments{
		margin: 0 40px;
		width: 1030px;
	}
	.letcomment{
		width: 1030px;
		margin: auto;
	}
	
	.geliceng{
		height: 50px;
	}
	.commentnav{
		display: block;
		font-size: 18px;
		padding: 20px 0;
		border-bottom:1px solid #DCDFE6;
	}
	.elbutton{
		margin: 10px 0;
		float: right;
	}
	.comment{
		width:1150px ;
		margin: auto;
		margin-top: 20px;
	}
	.artcontent{
		padding: 0 40px;
		margin: 50px 0;
	}
	P{
		text-indent:2em;
		font-size: 16px;
	}
	.content{
		width: 1150px;
		margin: auto;
		margin-top: 40px;
		.title{
			display: block;
			height: 60px;
			line-height: 60px;
			font-size: 22px;
			font-weight: bold;
			text-align: center;
		}
		.details{
			text-align: center;
			text{
				font-size: 14px;
				padding-left: 30px;
			}
			.firstchild{
				padding-left: 0;
			}
		}
	}
</style>
