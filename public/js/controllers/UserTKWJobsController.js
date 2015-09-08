app.controller('UserTKWJobsController', function ($scope, $http, $routeParams) {
  $scope.jobs = [];

  $scope.status = {
    '0': 'DRAFT',
    '1': 'PUBLISHED',
    '2': 'FILLED',
    '3': 'EXPIRED',
    '4': 'DASHBOARD'
  };

  $scope.logout = function(){
    Cookies.remove('consumer_key');
    Cookies.remove('secret_key');
  }

  //######################### JOBS ##########################################
  $scope.delete_job = function(id){
    $http.delete('/api/jobs/' + id + generate_url_key()).
    success(function(data){
      get_jobs();
    }).
    error(function(data){
      logged(data);
    });
  };

  get_jobs = function(){
    $http.get('api/jobs' + generate_url_key()).
    success(function(data){
      $scope.jobs = data['body'];
      $scope.numberOfJobs = $scope.jobs.length;
    }).
    error(function(data) {
      console.log(data)
      logged(data)
    });
  };

  get_jobs()

});
