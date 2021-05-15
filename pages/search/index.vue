<template>
	<view>
		<view class="top"
			style="width: 30%;height: 100px;background-color: rgba(0,0,0,0);margin: auto;padding-top: 100px;padding-left: 12px;">
			<uni-search-bar v-model="searchs" @confirm="thesearch" :placeholder="pl"
				style="background-color: rgba(0,0,0,0);display: inline-block;width: 80%;"></uni-search-bar>
			<button type="default"
				style="width: 15%;float: right;height: 30px;font-size: 14px;line-height: 30px;margin-top: 10px;"
				@click="thesearch">搜索</button>
		</view>
		<view style="width: 50%;margin: auto;background-color: #FFF;border-radius: 5px;">
			<el-tabs v-model="activeName" @tab-click="handleClick" style="padding: 10px;" stretch>
				<el-tab-pane label="文章" name="blog">
					<view style="width: 100%;margin: auto;margin-top: -20px;">
						<view class="box-card-father">
							<el-card class="box-card" v-for="(item,index) in blogList" :key='item.id'>
								<view>
									<view class="title-all">
										<text class="title" @click="toArticle(item.id)">{{item.title}}</uni-title>
											</text>
									</view>
								</view>
								<view class="creater">
									<text class="time el-icon-alarm-clock">{{item.createTime.split('T')[0]}}</text>
								</view>
							</el-card>
						</view>
					</view>
					<view class="Paginational">
						<el-pagination background @current-change="handleCurrentChange"
							@prev-click="handleCurrentChange" @next-click="handleCurrentChange"
							layout="total,prev, pager, next" :total="count" :page-size="10">
						</el-pagination>
					</view>
				</el-tab-pane>
				<el-tab-pane label="用户" name="user">
					<view style="width: 85%;margin: auto;margin-top: -20px;">
						<view class="box-card-father">
							<el-card class="box-card" v-for="(item,index) in userlist" :key='item.id'>
							    <image 
								:src="item.avatar?item.avatar:'https://pic4.zhimg.com/80/v2-aecc6d4f86aed329f65ad8dae802a918_720w.jpg?source=1940ef5c'"
								mode="aspectFill"
								style="height: 100px;width: 100px;border-radius: 50%;margin-left: 25px;vertical-align:middle"
								>
								</image>
								<view 
								style="display: inline-block;height: 100px;line-height: 40px;font-size: 20px;vertical-align:middle;margin-left: 10px;font-weight: 400;cursor: pointer;"
								class="namesss"
								@click="gotohome(item.id,item.nickname)"
								>
									{{item.nickname}}
									<view style="font-size: 14px;color: #6d757a;;">
									此用户没有个性签名啊啊啊	
									</view>
								</view>
							</el-card>
						</view>
					</view>
				</el-tab-pane>
			</el-tabs>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				searchs: '',
				pl: '',
				count: 0,
				pageNum: 1,
				blogList: [],
				userlist: [],
				activeName: 'blog'
			}
		},
		methods: {
			gotohome(e,tname) {
				this.$router.push(
				{path: '/index/home', query: {user:e,nickname:tname}}
				)
			},
			toArticle(e) {
				this.$router.push({
					path: '/index/articledetal',
					query: {
						id: e,
						type: 1
					}
				})
			},
			async thesearch() {
				console.log(this.searchs)
				const res = await this.$http({
					url: '/searchAll',
					data: {
						keyword: this.searchs.value,
						pageNum: this.pageNum
					}
				})
				this.pl = this.searchs.value
				this.blogList = res.data.data.blogs
				this.userlist = res.data.data.users
				console.log(res)
			},
			async thesearch1(e) {
				console.log(this.searchs)
				this.pl = e
				const res = await this.$http({
					url: '/searchAll',
					data: {
						keyword: e,
						pageNum: this.pageNum
					}
				})
				this.blogList = res.data.data.blogs
				this.userlist = res.data.data.users
				this.count = res.data.data.total
				console.log(res)
			},
			handleCurrentChange(e) {
				this.pageNumber = e
				this.thesearch()
			},
			handleClick(tab, ) {
				console.log(tab);
			}

		},
		created() {
			if (this.$route.query.query) {
				this.pl = this.$route.query.query
				this.thesearch1(this.$route.query.query)
			}
		}
	}
</script>

<style lang="less">
	.namesss:hover{
		color: #00a1d6;
	}
	.box-card-father {
		margin-top: 30px;

		.box-card {
			margin-bottom: 10px;

			.title-all {
				padding-left: 10px;
				padding-bottom: 10px;
				font-size: 20px;
				font-weight: 500;
				line-height: 36px;
				height: 36px;
				color: rgb(62, 175, 124);
				border-bottom: 1px solid rgba(36, 36, 36, .1);

				.title {
					cursor: pointer;
				}
			}

			.creater {
				color: rgb(127, 127, 127);
				margin-top: 10px;
				padding-left: 10px;

				text {
					font-size: 14px;
					display: inline-block;
					margin-right: 16px;
				}
			}
		}
	}

	.tags {
		display: flex;
		flex-wrap: wrap;
		width: 100%;
		margin-top: 20px;

		.tag {
			// width: 10%;
			margin: 10px;
			cursor: pointer;
		}
	}

	.Paginational {
		width: 100%;
		margin-top: 30px;
		text-align: center;
	}
</style>
