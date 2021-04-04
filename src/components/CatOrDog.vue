<template>
    <div class="main">
        <p> {{ title }} </p>
        <p> Try to guess what pet will be shown next</p>
        <div class="buttons">
            <button class="cat" :disabled="buttonsDisabled" v-on:click="onCatClick">🐈</button>
            <button class="dog" :disabled="buttonsDisabled" v-on:click="onDogClick">🐕</button>
        </div>
        <p class="score-title">Your score is:</p>
        <p class="score" :class="{ 'green': score > 0, 'red': score < 0 }"> {{ score }}</p>
        <div v-show="isLoaderShowed" class="loader"></div>
        <img class="pic" v-show='!isLoaderShowed' :src="src" alt="" v-images-loaded="loaded">

    </div>
</template>

<script>
    import imagesLoaded from 'vue-images-loaded'

    export default {
        directives: {
            imagesLoaded
        },
        name: "CatOrDog",
        data: function () {
            return {
                title: "Welcome to a CatOrDog game!",
                src: "",
                score: 0,
                nextOneIsCat: true,
                isLoaderShowed: false,
                buttonsDisabled: false,
                temporalScore: 0
            };
        },
        methods: {
            loaded: function () {
                this.isLoaderShowed = false;
                this.buttonsDisabled = false;
                this.score = this.score + this.temporalScore;
                this.temporalScore = 0;
            },
            onCatClick: function () {
                this.displayResult(true)
            },
            onDogClick: function () {
                this.displayResult(false)
            },
            displayResult: function (shouldBeCat) {
                if (Math.random() >= 0.5) {
                    this.fetchCat()
                        .then(() => shouldBeCat ? this.temporalScore = 1 : this.temporalScore = -1)

                } else {
                    this.fetchDog()
                        .then(() => !shouldBeCat ? this.temporalScore = 1 : this.temporalScore = -1)
                }
            },
            fetchCat: function () {
                this.isLoaderShowed = true;
                this.buttonsDisabled = true;
                return fetch("https://aws.random.cat/meow")
                    .then(res => res.json())
                    .then(res => this.src = res.file)

            },
            fetchDog: function () {
                this.isLoaderShowed = true;
                this.buttonsDisabled = true;
                return fetch("https://dog.ceo/api/breeds/image/random")
                    .then(res => res.json())
                    .then(res => this.src = res.message)
            }
        }
    }


</script>

<style scoped>
    .pic {
        max-height: 50vh;
        width: auto;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
        border-radius: 10px;
    }

    p {
        text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000, 1px 1px 0 #000;
        transition: 0.4s;
        margin: 0 0 15px;
    }

    .red {
        color: red;
    }

    .green {
        color: darkgreen;
    }
    .score {
        font-size: 30px;
    }
    button {
        margin-bottom: 30px;
        font-size: 35px;
        width: 220px;
        height: 50px;
        border: none;
        outline: none;
        color: #fff;
        background: #111;
        cursor: pointer;
        position: relative;
        z-index: 0;
        border-radius: 10px;
        margin-left: 10px;
    }

    button:before {
        content: '';
        background: linear-gradient(45deg, #ff0000, #ff7300, #fffb00, #48ff00, #00ffd5, #002bff, #7a00ff, #ff00c8, #ff0000);
        position: absolute;
        top: -2px;
        left: -2px;
        background-size: 400%;
        z-index: -1;
        filter: blur(5px);
        width: calc(100% + 4px);
        height: calc(100% + 4px);
        animation: glowing 20s linear infinite;
        opacity: 0;
        transition: opacity .3s ease-in-out;
        border-radius: 10px;
    }

    button:active {
        color: #000
    }

    button:active:after {
        background: transparent;
    }

    button:hover:before {
        opacity: 1;
    }


    button:after {
        z-index: -1;
        content: '';
        position: absolute;
        width: 100%;
        height: 100%;
        background: #111;
        left: 0;
        top: 0;
        border-radius: 10px;
    }

    @keyframes glowing {
        0% {
            background-position: 0 0;
        }
        50% {
            background-position: 400% 0;
        }
        100% {
            background-position: 0 0;
        }
    }

    .loader,
    .loader:before,
    .loader:after {
        border-radius: 50%;
        width: 2.5em;
        height: 2.5em;
        -webkit-animation-fill-mode: both;
        animation-fill-mode: both;
        -webkit-animation: load7 1.8s infinite ease-in-out;
        animation: load7 1.8s infinite ease-in-out;
    }

    .loader {
        color: #f6fff7;
        font-size: 10px;
        margin: 80px auto;
        position: relative;
        text-indent: -9999em;
        -webkit-transform: translateZ(0);
        -ms-transform: translateZ(0);
        transform: translateZ(0);
        -webkit-animation-delay: -0.16s;
        animation-delay: -0.16s;
    }

    .loader:before,
    .loader:after {
        content: '';
        position: absolute;
        top: 0;
    }

    .loader:before {
        left: -3.5em;
        -webkit-animation-delay: -0.32s;
        animation-delay: -0.32s;
    }

    .loader:after {
        left: 3.5em;
    }

    @-webkit-keyframes load7 {
        0%,
        80%,
        100% {
            box-shadow: 0 2.5em 0 -1.3em;
        }
        40% {
            box-shadow: 0 2.5em 0 0;
        }
    }

    @keyframes load7 {
        0%,
        80%,
        100% {
            box-shadow: 0 2.5em 0 -1.3em;
        }
        40% {
            box-shadow: 0 2.5em 0 0;
        }
    }

</style>