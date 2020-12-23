import {RouterMount,createRouter} from 'js_sdk/hhyang-uni-simple-router/uni-simple-router.js';

const router = createRouter({
	  h5:{
	    vueRouterDev:true,  //完全使用vue-router开发 默认 false  
	  },
	  platform: process.env.VUE_APP_PLATFORM,  
	  routes:[
	    {
	        path:'/index',
	        name:'index',
	        component:()=>import('@/pages/index/index.vue'),
			children:[
				{
					path:'/index/home',
					name:'home',
					component:()=>import('@/components/home/home.vue')
				},
				{
					path:'/index/article',
					name:'article',
					component:()=>import('@/components/home/article.vue')
				}	
			]
	    },
		{
		    path:'/login',
		    name:'login',
		    component:()=>import('@/pages/login/index.vue'),	
		}
	  ]
	});
//全局路由前置守卫
router.beforeEach((to, from, next) => {
	if(to.path === '/' || to.path === '/index'){
		next('/index/home')
	}
	next();
});
// 全局路由后置守卫
router.afterEach((to, from) => {
    console.log('跳转结束')
})

export {
	router,
	RouterMount
}