<template>

<view class="logins">
	<el-card class="maincontent">
			<view class="login">
		<el-form label-position="left" :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
			<!-- 用户名 -->
			<el-form-item label="用户名" prop="username">
				<el-input v-model="ruleForm.username"></el-input>
			</el-form-item>
	
			<el-form-item label="密码" prop="pass">
				<el-input type="password" v-model="ruleForm.pass"></el-input>
			</el-form-item>
			<view class="botton-a">
				<el-form-item>
				<el-button type="primary" @click="submitForm('ruleForm')">登陆</el-button>
				<el-button @click="tosign">注册</el-button>
			</el-form-item>
			</view>
			
		</el-form>
	</view>
	</el-card>
	<image src="../../static/role.jpg" mode="aspectFit" class="qiuren"></image>
</view>

</template>

<script>
	export default {
		data() {
			return {
				ruleForm: {
					username: '',

					pass: '',
				},
				rules: {
					username: [{
							required: true,
							message: '请输入用户名',
							trigger: 'blur'
						},
						{
							max: 12,
							message: '请输入3-12位的用户名',
							trigger: ['blur']
						},
						{
							min: 3,
							message: '请输入3-12位的用户名',
							trigger: ['blur']
						}
					],
					pass: [{
							required: true,
							message: '请输入密码',
							trigger: 'blur'
						},
						{
							max: 10,
							message: '请输入3-12位的密码',
							trigger: ['blur']
						},
						{
							min: 3,
							message: '请输入3-12位的密码',
							trigger: ['blur']
						}
					]
				}
			}
		},
		methods: {
			      submitForm(formName) {
			        this.$refs[formName].validate((valid) => {
			          if (valid) {
			            this.login(this.ruleForm)
			          } else {
			            this.$message.error('请输入正确格式的用户和密码')
			            return false;
			          }
			        });
			      },
			      resetForm(formName) {
			        this.$refs[formName].resetFields();
			      },
			async login(e) {
				const res = await uni.request({
					method: 'POST',
					url: '/api/login',
					data: {
						username: e.username,
						password: e.pass
					},
					header: {
						"Content-Type": "application/x-www-form-urlencoded"

					}
				})
				if(res[1].data.code !== 200){
					this.$message.error('用户名或密码错误请重新输入')
					console.log(res[1])
				}else{
					this.$message.success('登陆成功，正在跳转至首页')
					this.resetForm('ruleForm')
					sessionStorage.setItem('token','islogin')
					sessionStorage.setItem('id',res[1].data.data.user.id)
					sessionStorage.setItem('nickname',res[1].data.data.user.nickname)
					sessionStorage.setItem('img',res[1].data.data.user.avatar)
					console.log(res[1])
					setTimeout(
					()=>{this.$router.push("/index/home")},1500)
				}
			},
			tosign(){
				this.$router.push("/sign")
			},

		},
		created() {
			let state = sessionStorage.getItem('token')
			if(state === 'islogin'){
				this.$message.warning('已登录，请注销后再进行登陆')
			    setTimeout(
						()=>{this.$router.replace("index")},1500)
			}
		}
	}
</script>

<style lang="less">
	.qiuren{
		position: absolute;
		width:160px;
		height: 160px;
		top: 40%;
		left: 50%;
		transform: translate(-50%,-160%);
		z-index: 2;
		border-radius: 50%;
		box-shadow: 0px 0px 10px #808080;
	}
	.maincontent{
		position: absolute;
		width: 400px;
		top: 40%;
		left: 50%;
		padding: 40px;
		padding-bottom: 0;
		padding-top: 70px;
		transform: translate(-50%,-50%);	
		.botton-a{
			width: 300px;
			margin-left: 110px;
		}
	}
</style>
