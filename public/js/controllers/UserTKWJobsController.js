app.controller('UserTKWJobsController', function ($scope, $http, $routeParams) {
  $scope.jobs = [];

  $scope.status = {
    '0': 'DRAFT',
    '1': 'PUBLISHED',
    '2': 'FILLED',
    '3': 'EXPIRED',
    '4': 'DASHBOARD'
  };

  $scope.deleteJob = function(id){
    $http.delete('/api/jobs/' + id + generateUrlKey()).
    success(function(data){
      getJobs();
    }).
    error(function(data){
      logged(data);
    });
  };

  getJobs = function(){
    $http.get('api/jobs' + generateUrlKey()).
    success(function(data){
      console.log($scope.jobs)
      $scope.jobs = data['body'];
      $scope.numberOfJobs = $scope.jobs.length;
    }).
    error(function(data) {
      logged(data)
    });
  };

  getJobs()

});
