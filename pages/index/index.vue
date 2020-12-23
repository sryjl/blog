<template>
	<view class="content">
		<jl-iframe></jl-iframe>
		<view class="kong">
		</view>
		<router-view></router-view>   
	</view>
</template>

<script>
	export default {
		data() {
			return {
			}
		},
		methods: {
		},
		created() {
		},

	}
</script>

<style lang="less">
	.kong {
		height: 70px;
	}
</style>
