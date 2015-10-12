app.controller('UserTKWInterviewsShowController', function ($sce, $scope, $http, $routeParams) {

  $scope.jobId = window.location.href.split('/')[5];
  $scope.candidateId = window.location.href.split('/')[7];
  $scope.interviewId = $routeParams.id;
  $scope.candidate = {};
  $scope.commentText = '';

  //########################## INTERVIEWS ####################################
  $http.get('/api/interviews/' + $scope.interviewId + generateUrlKey()).
  success(function(data){
    $scope.interview = data['body'];
    getCandidate();
    getComments();
  }).
  error(function(data){
    logged(data);
  });

  //########################## CANDIDATES ####################################
  getCandidate = function(){
    $http.get('/api/candidates/' + $scope.interview.candidateId + generateUrlKey()).
    success(function(data){
      $scope.candidate = data['body'];
      getJob();
    }).
    error(function(data){
      logged(data);
    });
  }

  //########################### COMMENTS #####################################
  getComments = function(){
    $http.get('/api/comments' + generateUrlKey() + '&interview_id=' + $scope.interview.id).
    success(function(data){
      $scope.interviews = data['body']
      convertMarkdownToHtml($scope.interviews)
    }).
    error(function(data){
      logged(data);
    });
  }

  convertMarkdownToHtml = function(interviews){
    for(var i = 0; i<interviews.length; i++){
      $scope.test = []
      interviews[i].body = markdown.toHTML(interviews[i].body);
    }
  }

  $scope.createComment = function(){
    console.log($scope.commentText)
    console.log($scope.interview.id)
    $http.post('/api/comments/' + generateUrlKey(), {comment: {body: $scope.commentText, interview_id: $scope.interview.id}}).
    success(function(data){
      $scope.commentText = '';
      getComments();
    }).
    error(function(data){
      logged(data);
    });
  }

  //############################## JOB #######################################

  getJob = function(){
    $http.get('/api/jobs/' + $scope.candidate.jobId + generateUrlKey()).
    success(function(data){
      $scope.job = data['body']
    }).
    error(function(data){
      logged(data);
    });
  }

});
