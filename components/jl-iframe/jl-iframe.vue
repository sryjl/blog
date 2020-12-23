<template>
	<el-menu :default-active="activeIndex2" class="el-menu-demo" mode="horizontal" background-color="#545c64" text-color="#fff"
	 active-text-color="#ffd04b" @select="toPage">

		<view class="navlist">
			<text class="iconfont icon-boke-copy"></text>
			<el-menu-item index="1" class="el-menu-item-demo"><text class="iconfont icon-yemian"></text>首页</el-menu-item>
			<el-menu-item index="2" class="el-menu-item-demo"><text class="iconfont icon-pinglun" ></text>文章</el-menu-item>
			<el-menu-item index="3" class="el-menu-item-demo"><text class="iconfont icon-classify-act" ></text>分类</el-menu-item>
			<el-menu-item index="4" class="el-menu-item-demo"><text class="iconfont icon-biaoqian"></text>标签</el-menu-item>
			<el-menu-item index="5" class="el-menu-item-demo"><text class="iconfont icon-guidang" ></text>归档</el-menu-item>
			<el-menu-item index="6" class="el-menu-item-demo"><text class="iconfont icon-guanyu"></text>关于我</el-menu-item>
		</view>
		<view class="login login-user" v-if="islogin">
			<image :src="user.管理员.avatar" mode="aspectFill" class="userimg"></image>
			<el-submenu index="9" class="el-user">
				<template slot="title">秋人</template>
				<el-submenu index="9-1">
					<template slot="title">管理</template>
					<el-menu-item index="9-1-1">创建文章</el-menu-item>
					<el-menu-item index="9-1-2">创建标签</el-menu-item>
					<el-menu-item index="9-1-3">创建分类</el-menu-item>
				</el-submenu>
				<el-menu-item index="9-2" @click="loginout">注销</el-menu-item>
			</el-submenu>
		</view>
		<view class="login" v-else>
			<el-menu-item index="7" class="el-menu-item-demo-demo" @click='toLogin'>登录</el-menu-item>
			<el-menu-item index="8" class="el-menu-item-demo-demo">注册</el-menu-item>
		</view>
	</el-menu>
</template>

<script>
	export default {
		name: 'jlIframe',
		data() {
			return {
				user:{
					管理员:{
						avatar:''
						}
				},
				activeIndex2: '1',
				islogin:false,
				activeIndex1:''
			}
		},
		methods: {
			toPage(e){
				if(e===this.activeIndex1) return this.$message.warning({
					duration:1000,
					showClose:true,
					message:'您已处于该页面',
					offset:20
				})
				if(parseInt(e)<=6){
					sessionStorage.setItem('pagenum',e)
					this.activeIndex1 = e
				}
				if(e==='1'){
					this.$router.push('/index/home')
				}else if(e==='2'){
					this.$router.push('/index/article')
				}
			},
			toLogin(){
				console.log(this.activeIndex2)
				// uni.navigateTo({
				// 	url:'../login/index'
				// })
				this.$router.push("/login")
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
			let state = sessionStorage.getItem('token')
			let flag = sessionStorage.getItem('pagenum')
			if(flag){
		    this.activeIndex2 = flag
			this.activeIndex1 = flag
			}else{
				this.activeIndex2 = "1"
				this.activeIndex1 = "1"
			}

			if(state === 'islogin'){
				this.islogin =true
				this.getstatus()
			}
		}
	}
</script>

<style lang="less">
	
	:focus{
		outline: 0;
	}
	.login-user {
		.userimg{
			margin-top: 20px;
			height: 30px;
			width: 30px;
			border-radius: 50%;
			z-index: 2;
		}
		.el-user{
			margin-top: 7px;
	}
	}
	.el-menu-demo {
		position: fixed;
		top: 0;
		width: 100vw;
		z-index: 100;
		height: 70px;
	}
	.navlist {
		width: 350px;
		display: flex;
		position: relative;
		left: 55%;
		transform: translate(-160%, 0);
	
		.el-menu-item-demo {
			border-bottom: 2px solid #409EFF;
			height: 70px;
			line-height: 70px;
			font-size: 18px;
		}
	}
	.login {
		display: flex;
		position: absolute;
		top: 0;
		left: 50%;
		transform: translate(350px, 0);
	
		.el-menu-item-demo-demo {
			height: 70px;
			line-height: 70px;
		}
	}
	.icon-boke-copy {
		display: inline-block;
		font-size: 70px;
		line-height: 70px;
		color: #FFFFFF;
		margin-right: 50px;
	}
	
</style>
