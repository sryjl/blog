<template>
	<view style="width: 60%;margin: auto;margin-top: 50px;padding: 20px;background-color: white;">
		<el-table :data="blogList" style="width: 100%" :border="true">
			<el-table-column label="编号" width="180">
				<template slot-scope="scope">
					<span style="margin-left: 10px">{{ scope.$index+1 }}</span>
				</template>
			</el-table-column>
			<el-table-column label="名称" width="380">
				<template slot-scope="scope">
						<p>文章名: {{ scope.row.title }}</p>
				</template>
			</el-table-column>
			<el-table-column label="操作">
				<template slot-scope="scope">
					<el-button size="mini" @click="handleEdit2(scope.row.id)">编辑</el-button>
					<el-button size="mini" type="danger" @click="handleDelete1(scope.row.id)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		<el-dialog title="警告" :visible.sync="popupVisible" :width="'30%'">
			<view style="text-align: center;margin-bottom: 10px;">
				确认删除文章？
			</view>
		
			<view style="text-align: center;">
				<el-button @click="popupVisible = false">取 消</el-button>
				<el-button type="primary" @click="handleDelete()">确 定</el-button>
			</view>
		</el-dialog>
		<view style="margin-top: 20px;display: flex;justify-content: space-between;">
			<view>
				<el-button 
				size="medium" 
				@click="handleEdit(0)"
				:disabled="pageNum===0"
				>上一页</el-button>
				<el-button size="medium" @click="handleEdit(1)"
				:disabled="(pageNum+1)*10>=count"
				>下一页</el-button>
			</view>
			<el-button size="medium" @click="handleEdit(3)" type="success">新增</el-button>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				pageNum:0,
				deleteid:'',
				count:0,
				blogList:[],
				popupVisible:false,
			}
		},
		methods: {
			handleEdit(e) {
				if(e===0){
					this.pageNum--
					this.getdetail(this.pageNum)
				}else if(e===1){
					this.pageNum++
					this.getdetail(this.pageNum)
				}else if(e===3){
					this.$router.push('/create/createArticle')
				}
			},
			handleEdit2(e){
				this.$router.push(
				{path: '/create/createArticle', query: {id: e}}
				)
			},
			handleDelete1(e){
				this.deleteid = e
				this.popupVisible= true
			},
			async handleDelete() {
				const res = await this.$http({
					url:'/admin/delete/'+this.deleteid
				})
				if (res.data.code === 200) {
						this.$message.success('删除文章成功')
						this.getdetail(this.pageNum)
						this.popupVisible= false
				} else {
					this.$message.error('删除失败')
					this.popupVisible= false
				}			
			},
			async getdetail(val) {
				const res = await this.$http({
					url: '/blogPage?pageNumber=' + val+'&userId='+this.userid,
				})
				this.blogList = res.data.data.blogs
				this.count = res.data.data.count
				console.log(this.count)
			},
		},
		created() {
			this.userid=sessionStorage.getItem('id')
			this.nickname =sessionStorage.getItem('nickname')
			this.getdetail(0)
		}
	}
</script>

<style>
</style>
