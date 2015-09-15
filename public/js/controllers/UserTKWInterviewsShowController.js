app.controller('UserTKWInterviewsShowController', function ($scope, $http, $routeParams) {

  $scope.job_id = window.location.href.split('/')[5];
  $scope.candidate_id = window.location.href.split('/')[7];
  $scope.interview_id = $routeParams.id;
  $scope.candidate = {};
  $scope.comment_text = '';

  //########################## INTERVIEWS ####################################
  $http.get('/api/interviews/' + $scope.interview_id + generate_url_key()).
  success(function(data){
    $scope.interview = data['body'];
    get_candidate();
    get_comments();
  }).
  error(function(data){
    logged(data);
  });

  //########################## CANDIDATES ####################################
  get_candidate = function(){
    $http.get('/api/candidates/' + $scope.interview.candidate_id + generate_url_key()).
    success(function(data){
      $scope.candidate = data['body'];
      get_job();
    }).
    error(function(data){
      logged(data);
    });
  }

  //########################### COMMENTS #####################################
  get_comments = function(){
    $http.get('/api/comments' + generate_url_key() + '&interview_id=' + $scope.interview.id).
    success(function(data){
      $scope.interviews = data['body']
    }).
    error(function(data){
      logged(data);
    });
  }

  $scope.create_comment = function(){
    $http.post('/api/comments/' + generate_url_key(), {comment: {body: $scope.comment_text, interview_id: $scope.interview.id}}).
    success(function(data){
      $scope.comment_text = '';
      get_comments();
    }).
    error(function(data){
      logged(data);
    });
  }

  //############################## JOB #######################################

  get_job = function(){
    $http.get('/api/jobs/' + $scope.candidate.job_id + generate_url_key()).
    success(function(data){
      $scope.job = data['body']
    }).
    error(function(data){
      logged(data);
    });
  }

});
