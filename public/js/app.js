var app = angular.module('app', ['ngRoute', 'ngResource', 'ui.bootstrap.datetimepicker', 'ngSanitize'] );

var $ = function (id) { return document.getElementById(id); };

app.config(['$locationProvider', function($locationProvider) {
  $locationProvider.html5Mode(true);
}]);

app.config(['$routeProvider',
  function($routeProvider) {

    $routeProvider

    .when('/jobs', {
      templateUrl: 'partials/jobs/jobs.html',
      controller: 'JobsController',
    })

    .when('/jobs/:id', {
      templateUrl: 'partials/jobs/job.html',
      controller: 'JobController',
    })

    .when('/user_tkw/login', {
      templateUrl: 'partials/user_tkw/login.html',
      controller: 'LoginController',
    })

    .when('/user_tkw/jobs', {
      templateUrl: 'partials/user_tkw/jobs/jobs.html',
      controller: 'UserTKWJobsController',
    })

    .when('/user_tkw/jobs/new', {
      templateUrl: 'partials/user_tkw/jobs/new.html',
      controller: 'UserTKWJobsNewController',
    })

    .when('/user_tkw/jobs/:id', {
      templateUrl: 'partials/user_tkw/jobs/job.html',
      controller: 'UserTKWJobsShowController',
    })

    .when('/user_tkw/jobs/:id/edit', {
      templateUrl: 'partials/user_tkw/jobs/edit.html',
      controller: 'UserTKWJobsEditController',
    })

    .when('/user_tkw/jobs/:id/candidates/:id', {
      templateUrl: 'partials/user_tkw/candidates/show.html',
      controller: 'UserTKWCandidatesShowController',
    })

    .when('/user_tkw/jobs/:id/candidates/:id/edit', {
      templateUrl: 'partials/user_tkw/candidates/edit.html',
      controller: 'UserTKWCandidatesEditController',
    })

    .when('/user_tkw/jobs/:id/candidates/:id/interview/:id', {
      templateUrl: 'partials/user_tkw/interviews/show.html',
      controller: 'UserTKWInterviewsShowController',
    })

    .otherwise({
      redirectTo: function(current, path, search) {
        if(search.goto) {
          return "/" + search.goto
        } else {
          return "/jobs"
        }
      }
    });

}]);
