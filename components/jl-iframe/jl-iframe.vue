<template>
	<el-menu :default-active="$route.path" class="el-menu-demo" mode="horizontal" background-color="#545c64"
		text-color="#fff" active-text-color="#ffd04b" @select="toPage">

		<view class="navlist" v-if="seetype!=1">
			<text class="iconfont icon-boke-copy"></text>
			<el-menu-item index="/index/home" class="el-menu-item-demo"><text class="iconfont icon-yemian"></text>首页
			</el-menu-item>
			<el-menu-item index="/index/article" class="el-menu-item-demo"><text class="iconfont icon-pinglun"></text>文章
			</el-menu-item>
			<el-menu-item index="/index/class" class="el-menu-item-demo"><text
					class="iconfont icon-classify-act"></text>分类</el-menu-item>
			<el-menu-item index="/index/tags" class="el-menu-item-demo"><text class="iconfont icon-biaoqian"></text>标签
			</el-menu-item>
			<el-menu-item index="/index/doc" class="el-menu-item-demo"><text class="iconfont icon-guidang"></text>归档
			</el-menu-item>
			<el-menu-item index="/index/readme" class="el-menu-item-demo"><text class="iconfont icon-guanyu"></text>关于我
			</el-menu-item>
		</view>
		<view class="login login-user" v-if="islogin">
			<image :src="avatar" mode="aspectFill" class="userimg"></image>
			<el-submenu index="9" class="el-user">
				<template slot="title">{{nickname}}</template>
				<el-submenu index="9-1">
					<template slot="title">管理</template>
					<el-menu-item index="9-1-1">管理文章</el-menu-item>
					<el-menu-item index="9-1-2">管理分类</el-menu-item>
					<el-menu-item index="9-1-3">管理标签</el-menu-item>
				</el-submenu>
				<el-menu-item index="9-3">返回封面</el-menu-item>
				<el-menu-item index="9-2" @click="loginout">注销</el-menu-item>
			</el-submenu>
		</view>
		<view class="login" v-else>
			<el-menu-item index="7" class="el-menu-item-demo-demo" @click='tobox'>返回封面</el-menu-item>
		</view>
	</el-menu>
</template>

<script>
	export default {
		name: 'jlIframe',
		data() {
			return {
				user: {
					管理员: {
						avatar: ''
					}
				},
				seetype: '',
				userid: '',
				userid2: '',
				nickname2: '',
				nickname: '',
				activeIndex2: '1',
				islogin: false,
				activeIndex1: '',
				topy: ''
			}
		},
		methods: {
			toPage(e) {
				console.log(e)
				if (e === this.activeIndex1) return this.$message.warning({
					duration: 1000,
					showClose: true,
					message: '您已处于该页面',
					offset: 20
				})
				this.activeIndex1 = e
				if (e === '/index/home') {
					if (this.topy === 1) {
						this.$router.push({
							path: '/index/home',
							query: {
								user: this.userid2,
								nickname: this.nickname2
							}
						})
						return
					}
					this.$router.push('/index/home')
				} else if (e === '/index/article') {
					if (this.topy === 1) {
						this.$router.push({
							path: '/index/article',
							query: {
								user:this.userid2,
								nickname:this.nickname2
							}
						})
						return
					}
					this.$router.push('/index/article')
				} else if (e === '/index/class') {
					if (this.topy === 1) {
						this.$router.push({
							path: '/index/class',
							query: {
								user: this.userid2,
								nickname: this.nickname2
							}
						})
						return
					}
					this.$router.push('/index/class')
				} else if (e === '/index/tags') {
					if (this.topy === 1) {
						this.$router.push({
							path: '/index/tags',
							query: {
								user:this.userid2,
								nickname:this.nickname2
							}
						})
						return
					}
					this.$router.push('/index/tags')

				} else if (e === '/index/doc') {
					if (this.topy === 1) {
						this.$router.push({
							path: '/index/doc',
							query: {
								user:this.userid2,
								nickname:this.nickname2
							}
						})
						return
					}
					this.$router.push('/index/doc')

				} else if (e === '/index/readme') {
					if (this.topy === 1) {
						this.$router.push({
							path: '/index/readme',
							query: {
								user:this.userid2,
								nickname:this.nickname2
							}
						})
						return
					}
					this.$router.push('/index/readme')

				} else if (e === '9-1-1') {
					if (this.topy === 1) {
						this.$router.push({
							path: '/create/article',
							query: {
								user:this.userid2,
								nickname:this.nickname2
							}
						})
						return
					}
					this.$router.push('/create/article')
				} else if (e === '9-1-2') {
					if (this.topy === 1) {
						this.$router.push({
							path: '/create/class',
							query: {
								user:this.userid2,
								nickname:this.nickname2
							}
						})
						return
					}
					this.$router.push('/create/class')
				} else if (e === '9-1-3') {
					if (this.topy === 1) {
						this.$router.push({
							path: '/create/newtags',
							query: {
								user:this.userid2,
								nickname:this.nickname2
							}
						})
						return
					}
					this.$router.push('/create/newtags')
				} else if (e === '9-3') {
					this.$router.push('/box')
				}
			},
			tobox() {
				this.$router.push("/box")
			},
			tosign() {
				this.$router.push("/sign")
			},
			async getstatus() {
				const res = await this.$http({
					url: '/status'
				})
				this.user = res.data.data
			},
			async loginout() {
				const res = await this.$http({
					url: '/logout'
				})
				if (res.data.code === 200) {
					sessionStorage.removeItem('token')
					sessionStorage.removeItem('id')
					sessionStorage.removeItem('img')
					this.$message.success('已成功退出登录')
					this.islogin = false
					this.$router.push('/box');
				} else {
					this.$message.error('操作失败')
				}
			}
		},
		created() {
			let state = sessionStorage.getItem('token')
			this.userid = sessionStorage.getItem('id')
			this.nickname = sessionStorage.getItem('nickname')
			this.avatar = sessionStorage.getItem('img')
			if (this.$route.query.user) {
				this.userid2 = this.$route.query.user
				this.nickname2 = this.$route.query.nickname
				this.topy = 1
			}
			if (this.$route.query.type === 1) {
				this.seetype = 1
			}
			if (state === 'islogin') {
				this.islogin = true
				this.getstatus()
			}
		},
		onShow() {
			if (this.$route.query.type === 1) {
				this.seetype = 1
			} else {
				this.seetype = 0
			}
			if (this.$route.query.user) {
				this.userid2 = this.$route.query.user
				this.nickname2 = this.$route.query.nickname
				this.topy = 1
			}
		}
	}
</script>

<style lang="less">
	:focus {
		outline: 0;
	}

	.login-user {
		.userimg {
			margin-top: 20px;
			height: 30px;
			width: 30px;
			border-radius: 50%;
			z-index: 2;
		}

		.el-user {
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
