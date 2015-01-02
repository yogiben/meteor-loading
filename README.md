# [loading](https://loading.meteor.com)

A beautiful loading splash screen for your Meteor app

This is a bundle of PleaseWait.js + SpinKit CSS Spinners packaged for Meteor

PleaseWait.js<br>
**"A simple library to show your users a beautiful splash page while your application loads."**<br>
https://github.com/Pathgather/please-wait

SpinKit<br>
**"A collection of loading indicators animated with CSS."**<br>
https://github.com/tobiasahlin/SpinKit

## Install
```
meteor add pcel:loading
```

## Demo
[loading.meteor.com](https://loading.meteor.com)


## Usage

##### Template
```html
<template name="loading">
</template>
```

##### Javascript (pleaseWait demo/docs [here](http://pathgather.github.io/please-wait/))
```js
Template.loading.rendered = function () {
  this.loading = window.pleaseWait({
    logo: '/images/Meteor-logo.png',
    backgroundColor: '#7f8c8d',
    loadingHtml: message + spinner
  });
};

Template.loading.destroyed = function () {
  this.loading.finish();
};

var message = '<p class="loading-message">Loading Message</p>';
var spinner = '<div class="sk-spinner sk-spinner-rotating-plane"></div>';
```

##### CSS (SpinKit spinners: [here](http://tobiasahlin.com/spinkit/))
```css
.loading-message {
  color: #fff;
  font-size: 25px;
  font-weight: 300;
  font-family: sans-serif;
}

.sk-spinner-rotating-plane.sk-spinner {
  background-color: #fff;
}
```

##### Use with iron-router
```js
Router.configure({
  loadingTemplate: 'loading'
});
```
