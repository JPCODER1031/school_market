<template>
  <div class="collect" >
     <PageTitle>收藏夹</PageTitle>
     <div class="warp">
     <CollectItem v-for="collect in collects" :key="collect.g_id" :collectItem="collect"></CollectItem>
 
     </div>
  </div>
</template>

<script>
import PageTitle from '../../publicComponent/PageTitle'
import CollectItem from './collect/CollectItem';
import {mapState} from 'vuex';
export default {
    components:{
        PageTitle,
        CollectItem
    },
    data(){
        return{
            collects:[],
        }
    },
    methods:{
         getCollect(){
              this.$axios({
            url:'/goods/getCollects',
            method:'get',
            params:{
               u_id:this.userInfo.u_id
            }
        }).then(data=>{ 
            this.collects=data.data.collect;
        })
         }
    },
    created(){
       this.getCollect();
    },
    computed:{
        ...mapState({
            userInfo:'userInfo'
        })
    }
   
}
</script>

<style lang="less" scoped>
.collect{
    #warp();
}
.warp{
    width: 80%;
    display: flex;
    flex-flow: row wrap;
    justify-content: space-between;
}
</style>