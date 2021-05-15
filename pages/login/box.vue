<template>
	<view class="mask">
		<view style="color: white;text-align: center;margin-top: 18%;">
			<view><h1 style="font-weight: 400;">Aryaaa</h1></view>
			<view style="margin-top: 20px;margin-bottom: 20px;letter-spacing:10px">
				灵明无着，物来顺应，未来不迎，当时不杂，即过不恋。
			</view>
			<view>
				<el-button type="primary" @click="gotohome">进入博客</el-button>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
			}
		},
		methods: {
			gotohome() {
				const token = sessionStorage.getItem('token')
				if (token === 'islogin'){
					this.$router.push('/index/home')
				}else{
					this.$router.push('/login')
				}
			},
		}
	}
</script>

<style lang="less">
	.mask{
	  background: rgba(0,0,0,0.4) !important;
	  z-index: 10;
	  height: 100vh;
	  position: fixed;
	  width: 100vw;
	}
</style>
