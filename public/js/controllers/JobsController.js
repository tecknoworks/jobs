app.controller('JobsController', function ($scope, $http) {

  $scope.jobs = [];

  $http.get('api/jobs').success(function(data){
    $scope.jobs = data['body'];
    $scope.numberOfJobs = $scope.jobs.length;
  });
});
