var app = angular.module('app', ['ngRoute', 'ngResource']);

app.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider

    .when('/', {
      templateUrl: 'partials/jobs/jobs.html',
      controller: "JobsController"
    })

    .when('/jobs', {
      templateUrl: 'partials/jobs/jobs.html',
      controller: 'JobsController'
    })

    .when('/jobs/new', {
      templateUrl: 'partials/jobs/new.html',
      controller: 'CreateJobController'
    })

    .when('/jobs/:id', {
      templateUrl: 'partials/jobs/job.html',
      controller: 'JobController'
    })

    .otherwise({
      redirectTo: '/jobs'
    });

}]);
