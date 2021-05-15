<template>
	<view class="mask">
		<uni-search-bar v-model="searchs"
		@confirm="thesearch"
		style="width: 50%;background-color: rgba(0,0,0,0);margin: auto;margin-top: 100px;padding-left: 12px;"
		
		></uni-search-bar>
		<view style="color: white;text-align: center;margin-top: 8%;">
			<view><h1 style="font-weight: 400;">个人博客系统</h1></view>
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
				searchs:''
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
			thesearch(){
				this.$router.push(
				{path: '/search', query: {query: this.searchs.value}}
				)
			}
		},
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
