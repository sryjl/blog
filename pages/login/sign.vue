<template>
	<view style="width: 30%;margin: auto;margin-top: 50px;">

		<el-card style="padding: 30px;">
			<view style="text-align: center;margin-bottom: 20px;font-size: 20px;font-weight: blod;">
				注册账号
			</view>
			<el-form ref="form" :model="form" label-width="80px" :rules="rules">
				<el-form-item label="账号" prop="username">
					<el-input v-model="form.username" placeholder="请输入用户名"></el-input>
				</el-form-item>
				<el-form-item label="密码" prop="password">
					<el-input v-model="form.password" type="password" placeholder="请输入密码" show-password></el-input>
				</el-form-item>
				<el-form-item label="确认密码" prop="pass2">
					<el-input v-model="form.pass2" type="password" placeholder="请确认密码" show-password></el-input>
				</el-form-item>
				<el-form-item label="昵称" prop="nickname">
					<el-input v-model="form.nickname" placeholder="请输入昵称"></el-input>
				</el-form-item>
				<el-form-item label="邮箱" prop="email">
					<el-input v-model="form.email" placeholder="请输入邮箱"></el-input>
				</el-form-item>
				<view style="width: 40%;float: right;">
					<el-button type="primary" @click="onSubmit">提交</el-button>
					<el-button @click="restform">重置</el-button>
				</view>
			</el-form>
		</el-card>
	</view>
</template>
<script>
	export default {
		data() {
			const validatePass2 = (rule, value, callback) => {
				if (value === '') {
					callback(new Error('请再次输入密码'))
				} else if (value !== this.form.password) {
					callback(new Error('两次输入密码不一致!'))
				} else {
					callback()
				}
			}
			return {
				form: {
					username: '',
					password: '',
					pass2: '',
					nickname: '',
					email: ''
				},
				rules: {
					username: [{
							required: true,
							message: '请输入活动名称',
							trigger: 'blur'
						},
						{
							min: 3,
							max: 5,
							message: '长度在 3 到 5 个字符',
							trigger: 'blur'
						}
					],
					password: [{

						required: true,
						message: '请输入密码',
						trigger: 'blur'
					}, ],
					pass2: [{
						required: true,
						validator: validatePass2,
						trigger: 'blur'
					}],
					nickname: [{
						required: true,
						message: '请输入昵称',
						trigger: 'blur'
					}],
					email: [{
						type: 'email',
						required: true,
						message: '请输入正确的邮箱地址',
						trigger: 'blur'
					}]
				}
			}
		},
		methods: {
			onSubmit() {
				this.$refs.form.validate()
					.then(
						async () => {
							const res = await this.$http({
								url: '/register ',
								data: {
									username: this.form.username,
									password: this.form.password,
									nickname: this.form.nickname,
									email: this.form.email
								},
								method: 'POST'
							})
							console.log(res)
							if (res.data.code === 200) {
								this.$message.success('注册成功')
								this.$refs.form.resetFields();
								setTimeout(
									()=>{this.$router.push("/box")},500)
							} else {
								this.$message.error('操作失败')
							}
						}
					)
					.catch(
						(res) => {
							console.log(res)
						}
					)
			},
			restform(){
				this.$refs.form.resetFields();}
		}
	}
</script>

<style>
</style>
