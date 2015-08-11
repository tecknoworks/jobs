app.controller('JobsController', function ($scope, $http, $location) {

  $scope.jobs = [];

  $http.get('api/jobs').success(function(data){
    $scope.jobs = data['body'];
    $scope.numberOfJobs = $scope.jobs.length;
  });

  $scope.goTo = function (job) {
    $location.url('/jobs/' + job.id);
  }
});
