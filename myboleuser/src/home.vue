<script setup lang="ts">

import Header from "@/components/Headerbar.vue";
</script>

<template>
  <div class="common-layout">
    <el-container>
      <el-header><Header></Header></el-header>
      <el-main><router-view></router-view></el-main>
    </el-container>
  </div>
</template>




<style scoped>

</style>