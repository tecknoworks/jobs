app.controller('UserTKWJobsShowController', function ($scope, $http, $routeParams) {
  $scope.job_id = $routeParams.id;
  $scope.job = {};
  $scope.candidate = {};

  //############################## JOBS #####################################
  $http.get('api/jobs/' + $scope.job_id + generate_url_key()).
  success(function(data){
    $scope.job = data['body'];
    get_candidates()
    md_content = $scope.job.description
    $scope.html_content = markdown.toHTML( md_content );
    $("markout").innerHTML = $scope.html_content
  }).
  error(function(data){
    logged(data);
  });

  $scope.delete_job = function(id){
    $http.delete('/api/jobs/' + $scope.job.id + generate_url_key()).
    success(function(data){
      window.location.replace("/user_tkw/jobs");
    }).
    error(function(data){
      logged(data);
    });
  };

  //############################ CANDIDATES ##################################
  get_candidates = function(){
    $http.get('api/candidates' + generate_url_key() + '&job_id=' + $scope.job.id).
    success(function(data){
      $scope.candidates = data['body'];
    }).
    error(function(data){
      logged(data)
    });
  };

  $scope.create_candidate = function(){
    $scope.candidate['job_id'] = $scope.job.id

    $http.post('/api/candidates' + generate_url_key(), {candidate: $scope.candidate}).
    success(function(data, status, headers, config) {
      $scope.candidate = {};
      get_candidates();
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }

  $scope.delete_candidate = function(id){
    $http.delete('/api/candidates/' + id + generate_url_key()).
    success(function(data){
      get_candidates()
    }).
    error(function(data){
      logged(data);
    });
  };

});
