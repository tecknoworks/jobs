app.controller('UserTKWJobsShowController', function ($scope, $http, $routeParams) {
  $scope.job = {};
  $scope.attachments = [];
  $scope.attach = {};
  $scope.candidate = {};

  $http.get('api/jobs/'+$routeParams.id + generate_url_key()).
  success(function(data){
    $scope.job = data['body'];
    md_content = $scope.job.description
    $scope.html_content = markdown.toHTML( md_content );
    $("markout").innerHTML = $scope.html_content
  }).
  error(function(data){
    logged(data);
  });

  get_candidates = function(){
    $http.get('api/jobs/' + $routeParams.id + '/candidates' + generate_url_key()).
    success(function(data){
      $scope.candidates = data['body'];
      console.log($scope.candidates)
    }).
    error(function(data){
      logged(data)
    });
  };

  get_candidates()

  $scope.create_candidate = function(){
    $http.post('/api/jobs/' + $scope.job.id + '/candidates'  + generate_url_key(), {candidate: $scope.candidate}).
    success(function(data, status, headers, config) {
      $scope.rezultat = data;
      $scope.candidate = {};
      get_candidates();
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }

  $scope.delete_candidate = function(id){
    $scope.id = id;
    $http.delete('/api/jobs/' + $routeParams.id + '/candidates/' + id + generate_url_key()).
    success(function(data){
      get_candidates()
    }).
    error(function(data){
      logged(data);
    });
  };

  $scope.delete_job = function(id){
    $http.delete('/api/jobs/' + $routeParams.id + generate_url_key()).
    success(function(data){
      window.location.replace("/user_tkw/jobs");
    }).
    error(function(data){
      logged(data);
    });
  };
});
