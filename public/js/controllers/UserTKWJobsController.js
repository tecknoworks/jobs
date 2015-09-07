app.controller('UserTKWJobsController', function ($scope, $http, $routeParams) {
  $scope.jobs = [];

  $scope.delete_job = function(id){
    $http.delete('/api/jobs/' + id + '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')).success(function(data){
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

  $scope.logout = function(){
    Cookies.remove('consumer_key');
    Cookies.remove('secret_key');
    console.log(Cookies.get('consumer_key'))
    console.log(Cookies.get('secret_key'))
  }

  get_jobs = function(){
    $http.get('api/jobs?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')).success(function(data){
      $scope.jobs = data['body'];
      $scope.numberOfJobs = $scope.jobs.length;
    });
  };
  get_jobs()
});
