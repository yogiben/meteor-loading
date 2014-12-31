Template.loading.rendered = function () {
  // pick a random loading  message
  var message = randomMessage[Math.floor(Math.random() * randomMessage.length)];

  // launch splash
  var loading = window.pleaseWait({
    logo: '/images/Meteor-logo.png',
    backgroundColor: '#7f8c8d',
    loadingHtml: '<p class="loading-message">' + message + '</p>'
               + '<div class="sk-spinner sk-spinner-wandering-cubes">'
               + '  <div class="sk-cube1"></div>'
               + '  <div class="sk-cube2"></div>'
               + '</div>'
  });
  this.loading = loading;

  // manually remove loading for demo
  Meteor.setTimeout(function () {
    loading.finish();
  }, 3500);

};

Template.loading.destroyed = function () {
  this.loading.finish();
};

var randomMessage = [
  'Hey you. Welcome back!',
  'You look nice today',
  'Amazing things come to those who wait',
  'You usually have to wait for that which is worth waiting for',
  'Don\'t wait for opportunity. Create it.'
];
