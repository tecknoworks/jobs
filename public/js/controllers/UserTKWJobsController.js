app.controller('UserTKWJobsController', function ($scope, $http, $routeParams) {
  $scope.jobs = [];
  $scope.delete_job = function(id){
    $http.delete('/api/jobs/' + id).success(function(data){
      get_jobs();
    });
  };

  get_jobs = function(){
    $http.get('api/jobs').success(function(data){
      $scope.jobs = data['body'];
      $scope.numberOfJobs = $scope.jobs.length;
    });
  };
  get_jobs()
});
