app.controller('UserTKWCandidatesShowController', function ($scope, $http, $routeParams) {
  $scope.jobId = window.location.href.split('/')[5]
  $scope.candidateId = $routeParams.id
  $scope.job = {}
  $scope.candidate = {}
  $scope.interviews = []
  $scope.date = ''
  $scope.time = ''

  //########################## CANDIDATES ####################################
  $http.get('api/candidates/' + $scope.candidateId  + generateUrlKey()).
  success(function(data){
    $scope.candidate = data['body'];
    getJob();
    getAttachments();
    getInterviews();
    $scope.action = '/api/attachments' + generateUrlKey() + '&candidate_id=' + $scope.candidate.id
  }).
  error(function(data, status, headers, config) {
    logged(data)
  });

  $scope.deleteCandidate = function(){
    $http.delete('/api/candidates/' + $scope.candidate.id  + generateUrlKey()).
    success(function(data){
      window.location.href = "/user_tkw/jobs/" + $scope.jobId;
    }).
    error(function(data){
      logged(data)
    });
  };

  //########################## JOBS ##########################################
  getJob = function(){
    $http.get('api/jobs/' + $scope.candidate.job_id + generateUrlKey()).
    success(function(data){
      $scope.job = data['body'];
    }).
    error(function(data, status, headers, config) {
      logged(data);
    });
  }

  //######################### INTERVIEWS #####################################
  getInterviews = function() {
    $http.get('api/interviews' + generateUrlKey() + '&candidate_id=' + $scope.candidate.id).
    success(function(data){
      $scope.interviews = data['body'];
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }

  generateTimeFormat = function(time){
    return moment(time).year() + '-' + moment(time).month() + '-' +
    moment(time).day() + ' ' + moment(time).hour() + ':' +
    moment(time).minute()
  }

  $scope.createInterview = function(){
    var timeString = generateTimeFormat($scope.data.date)
    var interviewHash = {date_and_time: timeString, candidate_id: $scope.candidate.id}
    console.log(interviewHash)
    $http.post('api/interviews'  + generateUrlKey(), {interview: interviewHash}).
    success(function(data){
      getInterviews();
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  };

  //######################## ATTACHMENTS ####################################
  $scope.fileName = function(name){
    var array = name.split('/')
    return array[array.length-1]
  }

  getAttachments = function() {
    $http.get('api/attachments' + generateUrlKey() + '&candidate_id=' + $scope.candidate.id).
    success(function(data){
      $scope.attachments = data['body'];
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }
});
