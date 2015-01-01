meteor-loading
============

PleaseWait.js<br>
**"A simple library to show your users a beautiful splash page while your application loads."**<br>
https://github.com/Pathgather/please-wait

SpinKit<br>
**"A collection of loading indicators animated with CSS."**<br>
https://github.com/tobiasahlin/SpinKit

Install
---------------------
```
meteor add pcel:loading
```

Demo
---------------------
[loading.meteor.com](https://loading.meteor.com)


Usage
---------------------

##### Template
```html
<template name="loading">
</template>
```

##### JS (pleaseWait demo/docs [here](http://pathgather.github.io/please-wait/))
```js
Template.loading.rendered = function () {
  this.loading = window.pleaseWait({
    logo: '',
    backgroundColor: '#2980b9',
    loadingHtml: '<p class="loading-message">Loading Message</p>'
                +'<div class="sk-spinner sk-spinner-wandering-cubes"><div class="sk-cube1"></div><div class="sk-cube2"></div></div>'
  });
};

Template.loading.destroyed = function () {
  this.loading.finish();
};
```

##### Custom CSS (SpinKit spinners: [here](http://tobiasahlin.com/spinkit/))
```css
.pg-loading-screen .pg-loading-html p {
  color: #FFF;
  font-size: 25px;
  font-weight: 300;
  font-family: sans-serif;
}

.sk-spinner-wandering-cubes .sk-cube1, .sk-spinner-wandering-cubes .sk-cube2 {
  background-color: #fff;
  width: 12px;
  height: 12px;
}
```

##### Use with iron-router
```js
Router.configure({
  loadingTemplate: 'loading'
});
```
