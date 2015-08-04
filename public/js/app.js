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

    .when('/jobs/:id', {
      templateUrl: 'partials/jobs/job.html',
      controller: 'JobController'
    })

    .when('/new_job', {
      templateUrl: 'partials/jobs/new.html',
      controller: 'CreateJobController'
    })

    .otherwise({
      redirectTo: '/jobs'
    });

  }]);
