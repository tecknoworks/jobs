app.controller('UserTKWCandidatesShowController', function ($scope, $http, $routeParams) {
  $scope.job_id = window.location.href.split('/')[5]
  $scope.candidate_id = $routeParams.id
  $scope.job = {}
  $scope.candidate = {}
  $scope.interviews = []
  $scope.date = ''
  $scope.time = ''

  //########################## CANDIDATES ####################################
  $http.get('api/candidates/' + $scope.candidate_id  + generate_url_key()).
  success(function(data){
    $scope.candidate = data['body'];
    get_job();
    get_attachments();
    get_interviews();
    $scope.action = '/api/attachments' + generate_url_key() + '&candidate_id=' + $scope.candidate.id
  }).
  error(function(data, status, headers, config) {
    logged(data)
  });

  $scope.delete_candidate = function(){
    $http.delete('/api/candidates/' + $scope.candidate.id  + generate_url_key()).
    success(function(data){
      window.location.replace("/user_tkw/jobs/" + $scope.job_id);
    }).
    error(function(data){
      logged(data)
    });
  };

  //########################## JOBS ##########################################
  get_job = function(){
    $http.get('api/jobs/' + $scope.candidate.job_id + generate_url_key()).
    success(function(data){
      $scope.job = data['body'];
    }).
    error(function(data, status, headers, config) {
      logged(data);
    });
  }

  //######################### INTERVIEWS #####################################
  get_interviews = function() {
    $http.get('api/interviews' + generate_url_key() + '&candidate_id=' + $scope.candidate.id).
    success(function(data){
      $scope.interviews = data['body'];
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }

  $scope.create_interview = function(){
    var interview_hash = {date_and_time: $scope.date + ' ' + $scope.time, candidate_id: $scope.candidate.id}
    $http.post('api/interviews'  + generate_url_key(), {interview: interview_hash}).
    success(function(data){
      get_interviews();
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  };

  //######################## ATTACHMENTS ####################################
  $scope.file_name = function(name){
    var array = name.split('/')
    return array[array.length-1]
  }

  get_attachments = function() {
    $http.get('api/attachments' + generate_url_key() + '&candidate_id=' + $scope.candidate.id).
    success(function(data){
      $scope.attachments = data['body'];
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }
});
