import Vue from 'vue'
import App from './App'
import request from 'common/js/request.js'
import {
	Tabs,
	TabPane,
Dialog,
Menu,
MenuItem,
Submenu,
Card,
Pagination,
Button,
Form,
FormItem,
Input,
Message,
Timeline,
TimelineItem,
Tag,
Table,
TableColumn,
Popover,
Select,
Option,
Col,
DatePicker,
Switch,
Checkbox,
CheckboxGroup,
Radio,
RadioGroup,
Avatar
} from 'element-ui'
Vue.config.productionTip = false
import {router,RouterMount} from 'router.js'  //路径换成自己的
Vue.use(router)
App.mpType = 'app'

Vue.use(Avatar)
Vue.use(Dialog)
Vue.use(Tabs)
Vue.use(TabPane)
Vue.use(Select)
Vue.use(Radio)
Vue.use(RadioGroup)
Vue.use(DatePicker)
Vue.use(Switch)
Vue.use(Checkbox)
Vue.use(CheckboxGroup)
Vue.use(Col)
Vue.use(Option)
Vue.use(Menu)
Vue.use(MenuItem)
Vue.use(Submenu)
Vue.use(Card)
Vue.use(Pagination)
Vue.use(Button)
Vue.use(Form)
Vue.use(FormItem)
Vue.use(Input)
Vue.use(Timeline)
Vue.use(TimelineItem)
Vue.use(Tag)
Vue.use(Table)
Vue.use(TableColumn)
Vue.use(Popover)
Vue.prototype.$http = request
Vue.prototype.$message = Message
const app = new Vue({
    ...App
})

//v1.3.5起 H5端 你应该去除原有的app.$mount();使用路由自带的渲染方式
// #ifdef H5
	RouterMount(app,router,'#app')
// #endif

// #ifndef H5
	app.$mount(); //为了兼容小程序及app端必须这样写才有效果
// #endif

