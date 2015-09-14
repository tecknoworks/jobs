app.controller('UserTKWInterviewsShowController', function ($scope, $http, $routeParams) {

  $scope.job_id = window.location.href.split('/')[5]
  $scope.candidate_id = window.location.href.split('/')[7]
  $scope.interview_id = $routeParams.id
  $scope.candidate = {}

  //########################## CANDIDATES ####################################
  $http.get('/api/candidates/' + $scope.candidate_id + generate_url_key()).
  success(function(data){
    $scope.candidate = data['body'];
    get_job($scope.candidate.job_id);
  }).
  error(function(data){
    logged(data);
  });

  //########################### COMMENTS #####################################
  $http.get('/api/comments/' + $scope.interview_id + generate_url_key()).
  success(function(data){

  }).
  error(function(data){

  })

  //########################## INTERVIEWS ####################################
  $http.get('/api/interviews/' + $scope.interview_id + generate_url_key()).
  success(function(data){
    $scope.interview = data['body']
  }).
  error(function(data){
    logged(data);
  });

  //############################## JOB #######################################

  get_job = function(id){
    $http.get('/api/jobs/' + id + generate_url_key()).
    success(function(data){
      $scope.job = data['body']
    }).
    error(function(data){
      logged(data);
    });
  }

});
