<template>
	<view style="width: 40%;margin: auto;">
		<view class="tags">
			<view class="tag" v-for="item,index in taglist" :key="item.id" @click="getTagsDetail(item.id)">
				<el-tag :type="gettype(index)" size="medium" :effect="active==item.id?'dark':'light'">{{item.name}}</el-tag>
			</view>
		</view>
	    <view class="box-card-father">
	    	<el-card class="box-card" v-for="(item,index) in blogList" :key='item.id'>
				<view>
					<view class="title-all">
						<text class="title"  @click="toArticle(item.id)">{{item.title}}</uni-title></text>
					</view>
				</view>
				<view class="creater">
					<text class="time el-icon-alarm-clock">{{item.createTime.split('T')[0]}}</text>
					<text class="el-icon-user-solid artist">{{nickname}}</text>
					<text class="iconfont icon-guidang artist"
					      @click="gotoClass(item.type.id)"
						  style="cursor: pointer;"
					>{{item.type.name?item.type.name:'暂无分类'}}</text>
					<text class="iconfont icon-biaoqian artist" v-if="item.tags.length>0">
						<text v-for="item1 in item.tags" 
						:key="item1.id" 
						style="display: inline-block;margin-right: 2px;cursor: pointer;"
						@click="getTagsDetail(item1.id)"
						>{{item1.name}}</text>
					</text>
					<text class="iconfont icon-biaoqian artist" v-else>暂无标签</text>
				</view>
	    	</el-card>
	    </view>
		<view class="Paginational">
			<el-pagination background  @current-change="handleCurrentChange" @prev-click="handleCurrentChange"
			 @next-click="handleCurrentChange" layout="total,prev, pager, next" :total="count" :page-size="10">
			</el-pagination>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				count: 0,
				active:'',
				blogList: [],
				taglist:[],
				topy:''
			}
		},
		methods: {
			gotoClass(e){
				if (this.topy === 1) {
					this.$router.push({
						path: '/index/class',
						query: {
							id: e,
							user:this.userid,
							nickname:this.nickname
						}
					})
					return
				}
				this.$router.push(
				{path: '/index/class', query: {id: e}}
				)
			},
			gettype(e){
				if(e%5==0) return ''
				if(e%5==1) return 'success'
				if(e%5==2) return 'info'
				if(e%5==3) return 'warning'
				if(e%5==4) return 'danger'
			},
			async getTagsDetail(e){
				this.active = e
				const res =await this.$http({
					url:/allTags/+e
				})
				console.log(res)
				this.blogList = res.data.data.blogs
				this.count=this.blogList.length
			},
			toArticle(e){
				if (this.topy === 1) {
					this.$router.push({
						path: '/index/articledetal',
						query: {
							id: e,
							user:this.userid,
							nickname:this.nickname
						}
					})
					return
				}
				this.$router.push(
				{path: '/index/articledetal', query: {id: e}}
				)
			},
			async getdetail(val) {
				const res = await this.$http({
					url: '/blogPage?pageNumber=' + val+'&userId='+this.userid,
				})
				this.blogLists = res.data.data.blogs
				this.blogList = res.data.data.blogs.slice(0,10)
				this.count = this.blogLists.length
			},
			handleCurrentChange(e) {
				this.pageNumber = e
				if(this.active===''){
					let val = e - 1
					this.getdetail(val)
				}else{
					let val = e - 1
					let a = 10*val
					let b = 10*val+10
					this.blogList = this.blogLists.slice(a,b)
				}
			},
			async gettags(e){
				const res = await this.$http({
					url:'admin/tagControl',
				})
				this.taglist = res.data.data.tags
				console.log(res.data)
				console.log(this.taglist)
			}
			
		},
		created() {
			this.userid=sessionStorage.getItem('id')
			this.nickname =sessionStorage.getItem('nickname')
			if (this.$route.query.user) {
				this.userid = this.$route.query.user
				this.nickname = this.$route.query.nickname
				this.topy = 1
			}
			if(this.$route.query.id){
				this.getTagsDetail(this.$route.query.id)
			}else{
				this.getdetail(0)
			}
			this.gettags('allTags')
		},

	}
</script>

<style lang="less">
	.box-card-father{
		margin-top: 30px;
		.box-card{
			margin-bottom: 10px;
			.title-all{
				padding-left: 10px;
				padding-bottom: 10px;
				font-size: 20px;
				font-weight: 500;
				line-height: 36px;
				height: 36px;
				color: rgb(62, 175, 124);
				border-bottom: 1px solid rgba(36, 36, 36,.1);
				.title{
					cursor: pointer;
				}
			}
		    .creater{
				color: rgb(127, 127, 127);
				margin-top: 10px;
				padding-left: 10px;
				text{
					font-size: 14px;
					display: inline-block;
					margin-right: 16px;
				}
			}
		}
	}
	.tags{
		display: flex;
		 flex-wrap: wrap; 
		width: 100%;
		margin-top: 20px;
		.tag{
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
