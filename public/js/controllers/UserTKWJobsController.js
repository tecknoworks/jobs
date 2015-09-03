app.controller('UserTKWJobsController', function ($scope, $http, $routeParams) {
  $scope.jobs = [];
  $scope.delete_job = function(id){
    $scope.id = id
  };

  $http.get('api/jobs').success(function(data){
    $scope.jobs = data['body'];
    $scope.numberOfJobs = $scope.jobs.length;
  });

});
