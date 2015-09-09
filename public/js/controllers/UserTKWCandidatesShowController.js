app.controller('UserTKWCandidatesShowController', function ($scope, $http, $routeParams) {
  var FAIL = 0
  var PASS = 1

  $scope.job_id = window.location.href.split('/')[5]
  $scope.candidate_id = $routeParams.id
  $scope.job = {}
  $scope.candidate = {}
  $scope.interviews = []
  $scope.your_vote = 'None'
  $scope.status_hash = {
    '0': 'FAIL',
    '1': 'PASS'
  }
  //########################## JOBS ##########################################
  $http.get('api/jobs/' + $scope.job_id + generate_url_key()).
  success(function(data){
    $scope.job = data['body'];
  }).
  error(function(data, status, headers, config) {
    logged(data);
  });

  //########################## CANDIDATES ####################################
  $http.get('api/candidates/' + $scope.candidate_id  + generate_url_key()).
  success(function(data){
    $scope.candidate = data['body'];
  }).
  error(function(data, status, headers, config) {
    logged(data)
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

  $scope.delete_candidate = function(){
    $http.delete('/api/candidates/' + $scope.candidate_id  + generate_url_key()).
    success(function(data){
      window.location.replace("/user_tkw/jobs/" + $scope.job_id);
    }).
    error(function(data){
      logged(data)
    });
  };

  //######################### INTERVIEWS #####################################
  select_your_vote = function() {
    $scope.your_vote = 'None';
    for (var i=0; i<$scope.interviews.length; i++){
      if ($scope.interviews[i]['user_id'] == Cookies.get('user_id')){
        $scope.your_vote = $scope.status_hash[$scope.interviews[i]['status']]
      }
    }
  }

  $scope.get_interviews = function() {
    $http.get('api/interviews' + generate_url_key() + '&candidate_id=' + $scope.candidate_id).
    success(function(data){
      $scope.interviews = data['body'];
      if( $scope.interviews.length == 0 ){
        $scope.interviews.push("Nu exista nici un interview");
      } else {
        create_statistics();
        select_your_vote();
      }
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }

  $scope.create_interview = function(id){
    $http.post('api/interviews'  + generate_url_key(), {interview: {user_id: 1, status: id, candidate_id: $scope.candidate_id}}).
    success(function(data){
      $scope.interview = data['body'];
      $scope.get_interviews();
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  };

  $scope.get_interviews();

  //######################## ATTACHMENTS ####################################
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

  $scope.get_attachments();

});
