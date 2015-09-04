app.controller('UserTKWCandidatesEditController', function ($scope, $http, $routeParams) {
  $scope.job_id = window.location.href.split('/')[5]
  $scope.candidate_id = $routeParams.id
  $scope.job = {}
  $scope.candidate = {}
  $scope.interviews = []

  $scope.status_hash = {
    '0': 'PASS',
    '1': 'FAIl'
  }

  $http.get('api/jobs/'+$scope.job_id).success(function(data){
    $scope.job = data['body'];
  }).
  error(function(data, status, headers, config) {
    $scope.rezultat = data;
  });

  $http.get('api/jobs/'+$scope.job_id + '/candidates/'+$scope.candidate_id).success(function(data){
    $scope.candidate = data['body'];
  }).
  error(function(data, status, headers, config) {
    $scope.rezultat = data;
  });

  $scope.get_interviews = function(){
    $http.get('api/jobs/'+$scope.job_id + '/candidates/' + $scope.candidate_id + '/interviews').success(function(data){
      $scope.interviews = data['body'];
      if( $scope.interviews.length == 0 ){
        $scope.interviews.push("Nu exista nici un interview");
      }
    }).
    error(function(data, status, headers, config) {
      $scope.rezultat = data;
    });
  }

  $scope.get_jobs = function() {
    $http.get('/api/jobs').success(function(data){
      $scope.jobs = data['body'];
      console.log($scope.jobs)
    }).
    error(function(data, status, headers, config) {
      $scope.rezultat = data;
    });
  }

  $scope.create_interview = function(id){
    $http.post('api/jobs/'+$scope.job_id + '/candidates/' + $scope.candidate_id + '/interviews', {interview: {user_id: 1, status: id, candidate: $scope.candidate_id}}).success(function(data){
      $scope.interview = data['body'];
      $scope.get_interviews();
    }).
    error(function(data, status, headers, config) {
      $scope.rezultat = data;
    });
  };

  $scope.get_interviews();
  $scope.get_jobs();

});
