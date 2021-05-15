<template>
	<view style="width: 40%;margin: auto;margin-top: 50px;">

		<el-card style="padding: 30px">
			<view style="text-align: center;margin-bottom: 20px;font-size: 20px;font-weight: blod;">
				{{thistype===0?'新建':'修改'}}文章
			</view>
			<el-form ref="form" :model="form" label-width="80px" :rules="rules">
				<el-form-item label="文章标题" prop="title">
					<el-input v-model="form.title" placeholder="请输入文章名"></el-input>
				</el-form-item>
				<el-form-item label="简介" prop="describe">
					<el-input v-model="form.describe" placeholder="请输入简介"></el-input>
				</el-form-item>
				<el-form-item label="内容" prop="content">
					<view style="border: 1px solid rgba(48, 49, 51,.1);">
						<view>
							<view>
								<view class="toolbar">
									<view class="iconfont icon-bold" @click="toolBarClick('bold')"></view>
									<view class="iconfont icon-italic" @click="toolBarClick('italic')"></view>
									<view class="iconfont icon-xiahuaxian1" @click="toolBarClick('header')"></view>
									<view class="iconfont icon-underline" @click="toolBarClick('underline')"></view>
									<view class="iconfont icon-strike" @click="toolBarClick('strike')"></view>
									<view class="iconfont icon-alignleft" @click="toolBarClick('alignleft')"></view>
									<view class="iconfont icon-aligncenter" @click="toolBarClick('aligncenter')"></view>
									<view class="iconfont icon-alignright" @click="toolBarClick('alignright')"></view>
									<view class="iconfont icon-link" @click="toolBarClick('link')"></view>
									<view class="iconfont icon-image" @click="toolBarClick('imgage')"></view>
									<view class="iconfont icon-qingkong" @click="toolBarClick('clear')"></view>
									<view class="iconfont editor_submit" @click="toolBarClick('submit')">保存</view>
								</view>
								<view class="my_textarea" contentEditable="true" v-model="content" ref="mytext" v-html="thisBlog.content">
									<!-- {{this.thisBlog.content}} -->
								</view>
								<qfAlert @closeAlert='closeAlert()' contentType='input' :isOpen='isOpen' ref='qfAlert_ipt' @submitAlert='submitLink'></qfAlert>
								<qfAlert @closeAlert='closeImageAlert()' contentType='image' :isOpen='isOpen4' ref='qfAlert' @submitAlert='submitImageLink'></qfAlert>
								<qfAlert contentType='text' content='请先选中要添加链接的文本!' :isOpen='isOpen2' @submitAlert='closeTip()'></qfAlert>
								<qfAlert @closeAlert='closeClean()' contentType='text' content='确定清空吗？' :isOpen='isOpen3' @submitAlert='isClean()'></qfAlert>
							</view>
						</view>
					</view>
				</el-form-item>
				<el-form-item label="分类" prop="typeId">
					    <el-select v-model="form.typeId" placeholder="请选择分类">
					      <el-option v-for="item,index in typelist" :key="item.id" :label="item.name" :value="item.id"></el-option>
					    </el-select>
				</el-form-item>
				<el-form-item label="标签" prop="tagIds">
					<el-select v-model="form.tagIds" placeholder="请选择标签" @change="changetags">
					<el-option v-for="item,index in taglist" :key="item.id" :label="item.name" :value="item.id" ></el-option>
					</el-select>
				</el-form-item>
				<view style="margin-left: 80px;margin-top: -10px;margin-bottom: 10px;">
					<el-tag
					  v-for="item in taglist"
					  v-show="tagIds.findIndex((its)=>its==item.id)!=-1"
					  :key="item.id"
					  closable
					  :disable-transitions="false"
					  @close="handleClose(item.id)"
					  style="margin-right: 5px;"
					  >
					  {{item.name}}
					</el-tag>
				</view>
				<el-form-item label="类型">
					<el-select v-model="form.flag" placeholder="请选择类型" @change="flagchange">
					<el-option label="原创" value="原创" ></el-option>
					<el-option label="转载" value="转载" ></el-option>
					<el-option label="翻译" value="翻译" ></el-option>
					</el-select>
				</el-form-item>
				<view style="padding: 20px;padding-left: 30px;">
					<el-checkbox-group v-model="form.kow">
					  <el-checkbox label="推荐" name="recommend" @change="recommendchange"></el-checkbox>
					  <el-checkbox label="转载声明" name="shareStatement" @change="shareStatementchange"></el-checkbox>
					  <el-checkbox label="赞赏" name="appreciation" @change="appreciationchange"></el-checkbox>
					  <el-checkbox label="评论" name="commentabled" @change="commentabledchange"></el-checkbox>
					  <!-- <el-checkbox label="原创" name="flag" @change="flagchange" :checked="flag===true"></el-checkbox> -->
					  <el-checkbox label="发布" name="published" @change="publishedchange" :checked="published===true"></el-checkbox>
					</el-checkbox-group>
				</view>
				<view style="width: 40%;float: right;">
					<el-button type="primary" @click="onSubmit">提交</el-button>
					<el-button @click="restform">重置</el-button>
				</view>
			</el-form>
		</el-card>
		<view style="width: 100%;height: 50px;">
			
		</view>
	</view>
</template>
<script>
	import uParse from '../../components/uParse/src/wxParse.vue'
	import qfAlert from '../../components/qf-alert.vue'
	export default {
		components: {
			uParse,
			qfAlert
		},
		data() {
			return {
				thistype:0,
				id:'',
				userid:'',
				nickname:'',
				form: {
					title: '',
					describe:'',
					typeId:'',
					tagIds:'',
					kow:[],
					flag:''
				},
				tagIds:[],
				typelist:[],
				taglist:[],
				view:'',
				content:'',
				recommend:false,
				shareStatement:false,
				appreciation:false,
				commentabled:false,
				flag:'',
				published:false,
				thisBlog:[],
				rules: {
					title: [{
							required: true,
							message: '请输入活动名称',
							trigger: 'blur'
						},
						],
				},
				link:'',
				imageLink:'',
				isOpen:false,
				isOpen2:false,
				isOpen3:false,
				isOpen4:false,
				endOffset:0,
				startOffset:0,
				endContainer:'',
				startContainer:'',
			}
		},
		methods: {
			handleClose(e){
				const idx = this.tagIds.findIndex((item)=>item==e)
				this.tagIds.splice(idx)
			},
			changetags(e){
				console.log(e)
				const idx = this.tagIds.findIndex((item)=>item==e)
				 if(idx === -1){
					 this.tagIds.push(e)
				 }else{
					 this.$message.warning('已选择该标签')
				 }
				this.form.tagIds = ''
			},
			recommendchange(e){
				this.recommend = e
				console.log(this.form.kow)
			},
			shareStatementchange(e){
				this.shareStatement = e
			},
			appreciationchange(e){
				this.appreciation =e
			},
			commentabledchange(e){
				this.commentabled=e
			},
			flagchange(e){
				this.flag =e
				console.log(e)
			},
			publishedchange(e){
				this.published = e
			},
			onSubmit() {
				const url1 = '/admin/addBlog'
				const url2 = '/admin/updateBlog'
				let url = ''
				let data = {}
				if(this.thistype === 1){
					url = url2
					data = {
						    id:parseInt(this.id),
							appreciation:this.appreciation,
							commentabled:this.commentabled,
							content:this.content.target?this.content.target.innerHTML:this.thisBlog.content,
							description:this.form.describe,
							firstPicture:null,
							flag:this.flag,
							published:this.published,
							recommend:this.recommend,
							shareStatement:this.shareStatement,
							title:this.form.title,
							typeId:this.form.typeId,
							userId:this.userid,
							tagIds:this.tagIds,
							views:this.view
						}
				}else{
					url = url1
					data = {
							appreciation:this.appreciation,
							commentabled:this.commentabled,
							content:this.content.target?this.content.target.innerHTML:this.thisBlog.content,
							description:this.form.describe,
							firstPicture:null,
							flag:this.flag,
							published:this.published,
							recommend:this.recommend,
							shareStatement:this.shareStatement,
							title:this.form.title,
							typeId:this.form.typeId,
							userId:this.userid,
							tagIds:this.tagIds,
						}
						console.log(data)
				}
				this.$refs.form.validate()
				.then(
				async()=>{
					const res = await this.$http({
						url,
						data,
						method:'POST'
					})
					if (res.data.code === 200) {
						if(this.thistype === 1){
							this.$message.success('修改文章成功')
						}else{
							this.$message.success('创建文章成功')
						}
						setTimeout(
							()=>{this.$router.push("/create/article")},500)
					} else {
						this.$message.error('操作失败')
					}			
				}
				)
				.catch(
				(res)=>{
					this.$message.error('操作失败,请确认是否修改文章内容')
					console.log(res)
				}
				)
			},
			restform(){
				this.$refs.form.resetFields();
				this.content.target.innerHTML = "";
				},
			async getDeatil(e){
				const res = await this.$http({
					url: '/thisBlog/' + e
				})
				this.thisBlog = res.data.data.thisBlog
				console.log(this.thisBlog)
				this.appreciation=this.thisBlog.appreciation
				if(this.appreciation===true){
					this.form.kow.push('赞赏')
				}
				this.commentabled=this.thisBlog.commentabled
				if(this.commentabled===true){
					this.form.kow.push('评论')
				}
				this.form.describe =this.thisBlog.description
				this.flag = this.thisBlog.flag,
				this.form.flag = this.thisBlog.flag
				this.published =this.thisBlog.published
				if(this.published===true){
					this.form.kow.push('发布')
				}
				this.recommend =this.thisBlog.recommend
				if(this.recommend===true){
					this.form.kow.push('推荐')
				}
				this.shareStatement =this.thisBlog.shareStatement
				if(this.shareStatement===true){
					this.form.kow.push('转载声明')
				}
			
				this.form.title =this.thisBlog.title,
				this.form.typeId =this.thisBlog.type.id,
				this.thisBlog.tags.forEach((item)=>{
					this.tagIds.push(item.id)
				})
				this.view = this.thisBlog.views
				// document.execCommand('insertHTML',false,this.thisBlog.content)
				// console.log(this.$refs.mytext)
				// this.content.target.innerHTML=this.thisBlog.content
			},
			toolBarClick(type) {
				if (type == 'bold') {
					var bold = document.execCommand("bold", false, null)
				} else if (type == "italic") {
					document.execCommand("italic", false, null)
				} else if (type == "header") {
					uni.showActionSheet({
						itemList: ["标题1", "标题2", "标题3", "标题4", "标题5", "标题6"],
						success: res => {
							switch (res.tapIndex) {
								case 0:
									document.execCommand("fontsize", false, 1);
									return;
								case 1:
									document.execCommand("fontsize", false, 2);
									return;
								case 2:
									document.execCommand("fontsize", false, 3);
									return;
								case 3:
									document.execCommand("fontsize", false, 4);
									return;
								case 4:
									document.execCommand("fontsize", false, 5);
									return;
								case 5:
									document.execCommand("fontsize", false, 6);
									return;
							}
						}
					})
				} else if (type == "underline") {
					alert("ok");
					document.execCommand("underline", false, null);
				} else if (type == "strike") {
					document.execCommand("strikeThrough", false, null)
				} else if (type == "alignleft") {
					document.execCommand("justifyLeft", false, null)
				} else if (type == "aligncenter") {
					document.execCommand("justifyCenter", false, null)
				} else if (type == "alignright") {
					document.execCommand("justifyRight", false, null)
				} else if (type == "link") {
					let selection  =  document.getSelection();
					console.log(selection.getRangeAt(0));
					if(selection.type == "Range"){
						var range = selection.getRangeAt(0);
						this.endOffset = range.endOffset;
						this.startOffset = range.startOffset;
						this.endContainer = range.endContainer;
						this.startContainer = range.startContainer;
						this.isOpen = 'true';
					} else {
						this.isOpen2 = 'true';
					}
				} else if (type == "imgage") {
					//document.execCommand("insertimage", false, "http://dinxin.suchenqiang.cn/public/upload/image/20190402/59310adb40594ae1fbdb5dd1fd009a15.jpg")
					let selection  =  document.getSelection();
					console.log(selection)
					if(selection.type != "None"){
						this.isOpen4 = 'true';
					}
				} else if (type == "clear") {
					/* uni.showModal({
						title: "提示",
						content: "确定清空?",
						success: res => {
							if (res.confirm) {
								this.myTextarea.target.innerHTML = "";
							}
						}
					}) */
					this.isOpen3 = 'true';
				} else if (type == "submit") {
					if(this.myTextarea!=''){
						this.$emit("getChild1",this.myTextarea.target.innerHTML);
					}
				} 
			},
			closeAlert() {
				this.isOpen = false;
			},
			closeImageAlert() {
				this.isOpen4 = false;
				this.$refs.qfAlert.imageLink = '';
			},
			closeTip() {
				this.isOpen2 = false;
			},
			closeClean() {
				this.isOpen3 = false;
			},
			submitLink(data) {
				this.link = this.$refs.qfAlert_ipt.link;
				this.isOpen = false;
				let selection  =  window.getSelection();
				let range  =  document.createRange();
				selection.removeAllRanges();
				range.setStart(this.startContainer,  this.startOffset);
				range.setEnd(this.endContainer,  this.endOffset);
				selection.addRange(range);
				document.execCommand("createlink", false, this.link);
			},
			submitImageLink(data) {
				this.isOpen4 = false;
				this.imageLink = this.$refs.qfAlert.imageLink;
				document.execCommand('insertHTML', false, "<image style='width:80%' src='"+this.imageLink+"'></image>");
				this.$refs.qfAlert.imageLink = '';
			},
			isClean() {
				this.closeClean();
				if(this.content!=''){
					this.content.target.innerHTML = "";
				}
			},
			async gettags(e){
				const res = await this.$http({
					url:'/'+e,
				})
				if(e=='admin/typeControl'){
					this.typelist = res.data.data.types
					console.log(this.typelist)
				}else if(e=='admin/tagControl'){
					this.taglist = res.data.data.tags
					console.log(this.taglist)
				}
				
			}
		},
		created() {
			this.userid=sessionStorage.getItem('id')
			this.nickname =sessionStorage.getItem('nickname')
			if(this.$route.query.id){
				this.getDeatil(this.$route.query.id)
				this.thistype = 1,
				this.id = this.$route.query.id
			}
			this.gettags('admin/typeControl')
			this.gettags('admin/tagControl')
		},
	}
</script>

<style lang="less">
	@import '../../static/LevineHua-editor/markdown.css';
	@import url("../../components/uParse/src/wxParse.css");
	.container {
		padding: 10px;
	}

	#editor {
		width: 100%;
		height: 300px;
		background-color: #CCCCCC;
	}
	.toolbar {
		width: 100%;
		border: none;
		box-shadow: 0 0upx 4upx rgba(0, 0, 0, 0.157), 0 0upx 4upx rgba(0, 0, 0, 0.227);
	}
	
	.toolbar .iconfont {
		display: inline-block;
		cursor: pointer;
		height: 61.6upx;
		width: 61.6upx;
		margin: 13upx 0 11upx 0upx;
		font-size: 33upx;
		padding: 10upx 13upx 11upx 8upx;
		color: #757575;
		border-radius: 11upx;
		text-align: center;
		background: none;
		border: none;
		outline: none;
		line-height: 2.2;
		vertical-align: middle;
	}
	.my_textarea{
		width: 100%;
		height: 200px;
		box-sizing: border-box;
		outline: none;
		padding: 10px;
		overflow: auto; 
	}
	.my_textarea .img{
		width: 80%!important;
	}
	.toolbar .editor_submit{
		font-size: 12px;
		line-height: 35px;
	}
</style>
