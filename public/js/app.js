var app = angular.module('app', ['ngRoute', 'ngResource']);

app.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider

    .when('/', {
      controller: "IndexPageController"
    })

  }]);
