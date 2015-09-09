app.controller('UserTKWCandidatesEditController', function ($scope, $http, $routeParams) {

  $scope.job_id = window.location.href.split('/')[5]
  $scope.candidate_id = $routeParams.id
  $scope.job = {}
  $scope.candidate = {}
  $scope.interviews = []
  $scope.dictionary_jobs = {}
  $scope.keys = []

  $scope.status_hash = {
    '0': 'PASS',
    '1': 'FAIl'
  }

  //######################## CANDIDATES ######################################
  $http.get('api/candidates/' + $scope.candidate_id + generate_url_key()).
  success(function(data){
    $scope.candidate = data['body'];
  }).
  error(function(data, status, headers, config) {
    logged(data);
  });

  $scope.save = function(){
    $scope.candidate['job_id'] = $scope.dictionary_jobs[$scope.select]
    $http.patch('api/candidates/' + $scope.candidate_id + generate_url_key(), {candidate: $scope.candidate}).
    success(function(data, status, headers, config){
      window.location.replace("/user_tkw/jobs/" + $scope.job.id + '/candidates/' + $scope.candidate.id);
    }).
    error(function(data, status, headers, config){
      logged(data);
    });
  };

  $scope.delete_candidate = function(){
    $http.delete('/api/jobs/' + $scope.job_id + '/candidates/' + $scope.candidate_id  + generate_url_key()).
    success(function(data){
      window.location.replace("/user_tkw/jobs/" + $scope.job_id);
    }).
    error(function(data){
      logged(data);
    });
  };

  //######################## JOBS ############################################
  generate_dictionary_jobs = function(){
    for (var i = 0; i<$scope.jobs.length; i++){
      $scope.dictionary_jobs[$scope.jobs[i]['title']] = $scope.jobs[i]['id']
    }
    $scope.keys = Object.keys($scope.dictionary_jobs)
    console.log($scope.dictionary_jobs);
  }

  $scope.get_jobs = function() {
    $http.get('/api/jobs'  + generate_url_key()).
    success(function(data){
      $scope.jobs = data['body'];
      generate_dictionary_jobs();
    }).
    error(function(data, status, headers, config) {
      logged(data);
    });
  }

  $http.get('api/jobs/' + $scope.job_id  + generate_url_key()).
  success(function(data){
    $scope.job = data['body'];
    $scope.select = $scope.job['title']
  }).
  error(function(data, status, headers, config) {
    logged(data);
  });

  $scope.get_jobs();

  //######################## INTERVIEWS ######################################
  $scope.get_interviews = function(){
    $http.get('api/interviews' + generate_url_key() + '&candidate_id=' + $scope.candidate_id).
    success(function(data){
      $scope.interviews = data['body'];
      if( $scope.interviews.length == 0 ){
        $scope.interviews.push("Nu exista nici un interview");
      }
    }).
    error(function(data, status, headers, config) {
      logged(data);
    });
  }

  $scope.delete_interview = function(id){
    $http.delete('/api/interviews/' + id  + generate_url_key() + '&candidate_id=' + $scope.candidate_id).
    success(function(data){
      $scope.get_interviews();
    }).
    error(function(data){
      logged(data);
    });
  }

  $scope.get_interviews();

  //######################## ATTACHMENTS #####################################
  $scope.file_name = function(name){
    var array = name.split('/')
    return array[array.length-1]
  }

  $scope.get_attachments = function() {
    $http.get('api/attachments' + generate_url_key() + '&candidate_id=3').
    success(function(data){
      $scope.attachments = data['body'];
      if( $scope.attachments.length == 0 ){
        $scope.attachments.push("Nu exista nici un atasament");
      }
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }

  $scope.delete_attachment = function(id){
    $http.delete('/api/attachments/' + id).
    success(function(data){
      $scope.get_attachments()
    }).
    error(function(data){
      logged(data)
    });
  };

  $scope.get_attachments();
});
