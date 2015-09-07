app.controller('UserTKWJobsShowController', function ($scope, $http, $routeParams) {
  $scope.job = {};
  $scope.attachments = [];
  $scope.attach = {};
  $scope.candidate = {};

  $http.get('api/jobs/'+$routeParams.id + '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')).success(function(data){
    $scope.job = data['body'];
    md_content = $scope.job.description
    $scope.html_content = markdown.toHTML( md_content );
    $("markout").innerHTML = $scope.html_content
  });

  get_candidates = function(){
    $http.get('api/jobs/' + $routeParams.id + '/candidates').success(function(data){
      $scope.candidates = data['body'];
    });
  };

  get_candidates()

  $scope.create_candidate = function(){
    $http.post('/api/jobs/' + $scope.job.id + '/candidates', {candidate: $scope.candidate}).
    success(function(data, status, headers, config) {
      $scope.rezultat = data;
      $scope.candidate = {};
      get_candidates();
    }).
    error(function(data, status, headers, config) {
      // $scope.msg = "Name/Email/Phone can't be nil"
    });
  }

  $scope.delete_candidate = function(id){
    $scope.id = id;
    $http.delete('/api/jobs/' + $routeParams.id + '/candidates/' + id).
    success(function(data){
      get_candidates()
    });
  };

  $scope.delete_job = function(id){
    $http.delete('/api/jobs/' + $routeParams.id + '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')).success(function(data){
      window.location.replace("/user_tkw/jobs");
    });
  };
});
