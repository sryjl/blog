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
				<text>作者: {{thisBlog.user.nickname}}</text>
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
					<el-input type="textarea" :rows="4" :placeholder="'请输入评论'" v-model="textarea"
						resize="none" :disabled="!thisBlog.commentabled  || isupdate" maxlength='300'
						show-word-limit>
					</el-input>
					<view class="elbutton">
						<el-button type="primary" @click="submitcom(0)" :loading="isupdate"
							:disabled="!thisBlog.commentabled || isupdate">提交评论</el-button>
					</view>
				</view>

				<!-- 留言板 -->
				<view class="geliceng">

				</view>
				<view class="gocomments" v-if="comments.length > 0">
					<text class="commentnav">评论({{comments.length}})</text>
					<view class="realcomment" v-for="(item,index) in comments" :key="item.id">
						<view class="navlist">
							<image :src="item.avatar?item.avatar:'https://pic4.zhimg.com/80/v2-aecc6d4f86aed329f65ad8dae802a918_720w.jpg?source=1940ef5c'" mode="aspectFit"></image>
							<text class="nickname">{{item.nickname}}</text>
							<text class="createtime">2020/12/25</text>
						</view>
						<text class="realcontent">{{item.content}}</text>
						<view class="realcomment1" v-for="(item1,index1) in item.replyComment" :key="item1.id">
							<view class="navlist">
								<image :src="item1.avatar" mode="aspectFit"></image>
								<text class="nickname">{{item1.nickname}}</text>
								<text class="createtime">2020/12/25</text>
							</view>
							<text class="realcontent">{{item1.content}}</text>
						</view>
						<text class="moreRemake" @click="openmore(item.id)">回复</text>
						<view style="margin-left: 40px;margin-bottom: 60px;">
							<el-input v-if="item.id === moreRemake" type="textarea" :rows="2" :placeholder="'请输入评论'" v-model="textarea1"></el-input>
						</view>
						<view class="elbutton" style="margin-top: -50px;">
							<el-button v-if="item.id === moreRemake" type="primary" @click="submitcom(item.id)"
								:loading="isupdate" :disabled="!thisBlog.commentabled || isupdate">提交评论
							</el-button>
						</view>
					</view>
				</view>

				<view v-else class="gocomments">
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
				isupdate: false,
				textarea: '',
				textarea1:'',
				id: '',
				thisBlog: {
					commentabled: false
				},
				islogin: false,
				comments: [],
				moreRemake: null
			}
		},
		methods: {
			openmore(i) {
				if (i === this.moreRemake) {
					return this.moreRemake = null
				} else {
					this.moreRemake = i
				}
			},
			submitcom(i) {
				if (this.isupdate) return
				if (this.textarea.trim() === ''&&i===0) {
					return this.$message.error({
						duration: 1000,
						message: '请输入内容后提交'
					})
				}else if(this.textarea1.trim() === ''&&i!==0){
					return this.$message.error({
						duration: 1000,
						message: '请输入内容后提交'
					})
				}
				this.isupdate = true
				this.sendcommit(i)
			},
			async sendcommit(i) {
				let content = ''
				if(i===0){
					content = this.textarea
				}else{
					content = this.textarea1
				}
				console.log(this.$route.query.id)
				const res = await uni.request({
					url: '/api/say',
					method: 'GET',
					data: {
						content:content,
						blogId: this.$route.query.id,
						parentCommentId: i
					},
				})
				console.log(res)
				this.isupdate = false
				if (res[1].data.code === 200) {
					if(i===0){
						this.textarea = ''
					}else{
						this.textarea1 = ''
					}
					this.getcomment()
					return this.$message.success({
						message: '评论成功',
						duration: 1000,
					})
				} else {
					this.getcomment()
					return this.$message.success({
						message: '游客评论成功',
						duration: 1000,
					})
				}
			},
			async getblogdetail() {
				const res = await this.$http({
					url: '/thisBlog/' + this.id
				})
				this.thisBlog = res.data.data.thisBlog

			},
			async getcomment() {
				const res1 = await this.$http({
					url: '/comment?blogId=' + this.$route.query.id
				})
				this.comments = res1.data.data.comments
			}

		},
		created() {
			this.id = this.$route.query.id
			let login = sessionStorage.getItem('token')
			if (login) {
				this.islogin = true
			}
			this.getblogdetail()
			this.getcomment()
		},
	}
</script>

<style lang="less">
	.liubai {
		height: 100px;
	}
	.realcomment1{
		margin-top: 10px;
		margin-left: 30px;
		margin-bottom: 10px;
		image {
			height: 20px;
			width: 20px;
			border-radius: 50%;
			vertical-align: middle;
		}
		.navlist {
			text {
				vertical-align: middle;
				margin-left: 10px;
				font-size: 12px;
			}
		
			.createtime {
				color: #808080;
			}
		}
		
		.realcontent {
			display: inline-block;
			width: 920px;
			margin: 0 40px;
			margin-top: 10px;
			overflow: hidden;
		}
	}
	.realcomment {
		margin-top: 30px;
		border-bottom: 1px solid #DCDFE6;
		image {
			height: 30px;
			width: 30px;
			border-radius: 50%;
			vertical-align: middle;
		}

		.navlist {
			text {
				vertical-align: middle;
				margin-left: 10px;
				font-size: 14px;
			}

			.createtime {
				color: #808080;
			}
		}

		.realcontent {
			display: inline-block;
			width: 950px;
			margin: 0 40px;
			margin-top: 10px;
			overflow: hidden;
		}
	}

	.gocomments {
		margin: 0 40px;
		width: 1030px;
	}

	.letcomment {
		width: 1030px;
		margin: auto;
	}

	.geliceng {
		height: 50px;
	}

	.commentnav {
		display: block;
		font-size: 18px;
		padding: 20px 0;
		border-bottom: 1px solid #DCDFE6;
	}

	.elbutton {
		margin: 10px 0;
		float: right;
	}

	.comment {
		width: 1150px;
		margin: auto;
		margin-top: 20px;
	}

	.artcontent {
		padding: 0 40px;
		margin: 50px 0;
	}

	P {
		text-indent: 2em;
		font-size: 16px;
	}

	.content {
		width: 1150px;
		margin: auto;
		margin-top: 40px;

		.title {
			display: block;
			height: 60px;
			line-height: 60px;
			font-size: 22px;
			font-weight: bold;
			text-align: center;
		}

		.details {
			text-align: center;

			text {
				font-size: 14px;
				padding-left: 30px;
			}

			.firstchild {
				padding-left: 0;
			}
		}
	}

	.moreRemake {
		display: inline-block;
		margin-top: 10rpx;
		font-size: 14px;
		color: rgb(45, 100, 179);
		float: right;
	}
</style>
