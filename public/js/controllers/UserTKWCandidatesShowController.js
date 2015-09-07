app.controller('UserTKWCandidatesShowController', function ($scope, $http, $routeParams) {
  var FAIL = 0
  var PASS = 1
  $scope.job_id = window.location.href.split('/')[5]
  $scope.candidate_id = $routeParams.id
  $scope.job = {}
  $scope.candidate = {}
  $scope.interviews = []
  $scope.status_hash = {
    '0': 'PASS',
    '1': 'FAIl'
  }

  $http.get('api/jobs/' + $scope.job_id  + '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')).success(function(data){
    $scope.job = data['body'];
  }).
  error(function(data, status, headers, config) {
    $scope.rezultat = data;
  });

  $http.get('api/jobs/'+$scope.job_id + '/candidates/'+$scope.candidate_id  + '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')).success(function(data){
    $scope.candidate = data['body'];
  }).
  error(function(data, status, headers, config) {
    $scope.rezultat = data;
  });

  create_statistics = function(){
    $scope.fail_interviews = 0;
    $scope.pass_interviews = 0;
    for(var i=0; i<$scope.interviews.length; i++){
      if( $scope.interviews[i].status == FAIL ){
        $scope.fail_interviews += 1;
      } else{
        $scope.pass_interviews += 1;
      };
    };
  };

  $scope.get_interviews = function() {
    $http.get('api/jobs/'+$scope.job_id + '/candidates/' + $scope.candidate_id + '/interviews'  + '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')).success(function(data){
      $scope.interviews = data['body'];
      if( $scope.interviews.length == 0 ){
        $scope.interviews.push("Nu exista nici un interview");
      } else {
        create_statistics();
      }
    }).
    error(function(data, status, headers, config) {
      $scope.rezultat = data;
    });
  }

  $scope.create_interview = function(id){
    $http.post('api/jobs/'+$scope.job_id + '/candidates/' + $scope.candidate_id + '/interviews'  + '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key'), {interview: {user_id: 1, status: id, candidate: $scope.candidate_id}}).success(function(data){
      $scope.interview = data['body'];
      $scope.get_interviews();
    }).
    error(function(data, status, headers, config) {
      $scope.rezultat = data;
    });
  };

  $scope.delete_candidate = function(){
    $http.delete('/api/jobs/' + $scope.job_id + '/candidates/' + $scope.candidate_id  + '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')).
    success(function(data){
      window.location.replace("/user_tkw/jobs/" + $scope.job_id);
    });
  };

  $scope.get_interviews();

});
