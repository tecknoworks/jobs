var app = angular.module('app', ['ngRoute', 'ngResource']);

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
      templateUrl: 'partials/user_tkw/jobs.html',
      controller: 'UserTKWJobsController',
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
