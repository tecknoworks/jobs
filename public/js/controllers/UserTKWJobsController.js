app.controller('UserTKWJobsController', function ($scope, $http, $routeParams) {
  $scope.jobs = [];
  $scope.delete_job = function(id){
    $http.delete('/api/jobs/' + id).success(function(data){
      get_jobs();
    });
  };

  $scope.status = {
    '0': 'DRAFT',
    '1': 'PUBLISHED',
    '2': 'FILLED',
    '3': 'EXPIRED',
    '4': 'DASHBOARD'
  };

  get_jobs = function(){
    $http.get('api/jobs').success(function(data){
      $scope.jobs = data['body'];
      $scope.numberOfJobs = $scope.jobs.length;
    });
  };
  get_jobs()
});
