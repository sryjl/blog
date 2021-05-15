<template>
	<view style="width: 60%;margin: auto;margin-top: 50px;padding: 20px;background-color: white;">
		<el-table :data="tableData" style="width: 100%" :border="true">
			<el-table-column label="编号" width="180">
				<template slot-scope="scope">
					<span style="margin-left: 10px">{{ scope.$index+1 }}</span>
				</template>
			</el-table-column>
			<el-table-column label="名称" width="380">
				<template slot-scope="scope">
					<view slot="reference" class="name-wrapper">
						<el-tag size="medium"  v-if="inputId !== scope.$index">{{ scope.row.name }}</el-tag>
						<el-input class="input-new-tag" v-if="inputVisible&&inputId==scope.$index" v-model="inputValue" ref="saveTagInput"
							size="small" @keyup.enter.native="handleInputConfirm(scope.$index,scope.row.id)" @blur="handleInputConfirm(scope.$index,scope.row.id)">
						</el-input>
					</view>
				</template>
			</el-table-column>
			<el-table-column label="操作">
				<template slot-scope="scope">
					<el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
					<el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		<view style="margin-top: 20px;display: flex;justify-content: space-between;">
			<el-button size="medium" @click="handleEdit(scope.$index, scope.row)" disabled>下一页</el-button>
			<el-button size="medium"  type="success" @click="popupVisible=true">新增</el-button>
		</view>
		<el-dialog title="新建标签" :visible.sync="popupVisible" :width="'30%'">
			<view style="text-align: center;margin-bottom: 10px;">
				<el-input v-model="inputs" placeholder="请输入标签名" style="width: 50%"></el-input>
			</view>

			<view style="text-align: center;">
				<el-button @click="popupVisible = false">取 消</el-button>
				<el-button type="primary" @click="addTag">确 定</el-button>
			</view>
		</el-dialog>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				inputs:'',
				tableData: [],
				inputVisible: false,
				inputValue: '',
				popupVisible:false,
				inputId: '',
			}
		},
		methods: {
			async addTag(){
				const res = await this.$http({
					url:'/admin/addTag',
					data:{
						name:this.inputs
					}
				})
				if (res.data.code === 200) {
					    this.inputId=''
						this.popupVisible=false
						this.$message.success('新增标签成功')
						this.gettags('allTypes')
				} else {
					this.$message.error('操作失败')
				}
			},
			handleEdit(index, row) {
				this.inputId = index
				this.inputValue = row.name
				this.inputVisible = true
				this.$nextTick(_ => {
					this.$refs.saveTagInput.$refs.input.focus();
				});
			},
			async handleDelete(index, row) {
				const res = await this.$http({
					url:'/admin/deleteTag/'+row.id,
				})
				if (res.data.code === 200) {
					    this.gettags('allTypes')
						this.$message.success('删除标签成功')
				} else {
					this.$message.error('操作失败')
			    }
			},
			handleClose(tag) {
				// this.dynamicTags.splice(this.dynamicTags.indexOf(tag), 1);
			},
			showInput() {
				this.inputVisible = true;
				this.$nextTick(_ => {
					this.$refs.saveTagInput.$refs.input.focus();
				});
			},

			async handleInputConfirm(e,id) {
				let inputValue = this.inputValue;
				if(this.inputValue ===''){
					this.inputVisible = false;
					this.inputId = ''
					this.inputValue = '';
					return
				}
				const res = await this.$http({
					url:'/admin/updateTag',
					data:{
						id,
						name:inputValue
					}
				})
				if (res.data.code === 200) {
						this.$message.success('修改分类成功')
				} else {
					this.$message.error('操作失败')
					this.inputVisible = false;
					this.inputId = ''
					this.inputValue = '';
					return
				}			
				if (inputValue) {
					this.tableData[e].name = inputValue 
				}
				this.inputVisible = false;
				this.inputId = ''
				this.inputValue = '';
			},
			async gettags(e){
				const res = await this.$http({
					url:'admin/tagControl',
				})
				this.tableData = res.data.data.tags
			}
		},
		created() {
			this.userid=sessionStorage.getItem('id')
			this.nickname =sessionStorage.getItem('nickname')
			this.gettags('allTypes')
		}
	}
</script>

<style>
	.el-tag+.el-tag {
		margin-left: 10px;
	}

	.button-new-tag {
		margin-left: 10px;
		height: 32px;
		line-height: 30px;
		padding-top: 0;
		padding-bottom: 0;
	}

	.input-new-tag {
		width: 90px;
		margin-left: 10px;
		vertical-align: bottom;
	}
</style>
