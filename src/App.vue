<template>
    <div id="app">
        <img class="logo" alt="DogAndCat" src="./assets/394.jpg">
        <CatOrDog/>
    </div>
</template>

<script>
    import CatOrDog from "@/components/CatOrDog";

    export default {
        name: 'app',
        components: {
            CatOrDog
        }
    }
</script>

<style>
    @import "../node_modules/roboto-fontface/css/roboto/roboto-fontface.css";

    body {
        background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('./assets/f364b7d0a49566891789d291b8b2e53f.png');
        background-size: cover;
    }

    #app {
        font-family: 'Roboto', Helvetica, Arial, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        text-align: center;
        font-weight: bold;
        color: #f6fff7;
        margin-top: 60px;
    }

    .logo {
        max-width: 5vw;
        height: auto;
    }
</style>
