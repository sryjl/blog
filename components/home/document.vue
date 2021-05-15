<template>
	<view style="width: 50%;margin: auto;margin-top: 50px;">
		<div class="block">
		  <el-timeline>
		    <el-timeline-item v-for="(item,index) in blogList" :timestamp="item.updateTime.split('T')[0]" placement="top" :key="item.id">
		      <el-card>
		        <h4>{{item.title}}</h4>
		        <p>{{nickname}} 提交于 {{item.updateTime.split('T')[0]+'-'+item.updateTime.split('T')[1].split('+')[0].substr(0,8)}}</p>
		      </el-card>
		    </el-timeline-item>
		  </el-timeline>
		</div>
	</view>
</template>

<script>
	export default{
		data(){
			return{
				userid:'',
				nickname:'',
				blogList:[]
				}
		},
		methods:{
			async getDocument(){
				// this.active = e
				const res =await this.$http({
					url:'/records?userId='+this.userid
				})
				this.blogList = res.data.data.blogs
				console.log(this.blogList)
			},
		},
		created() {
			this.userid=sessionStorage.getItem('id')
			this.nickname =sessionStorage.getItem('nickname')
			this.getDocument()
		}
	}
</script>

<style>
</style>
