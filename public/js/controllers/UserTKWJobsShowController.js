app.controller('UserTKWJobsShowController', function ($scope, $http, $routeParams) {
  $scope.job = {};
  $scope.attachments = [];
  $scope.attach = {};
  $scope.candidate = {};

  $http.get('api/jobs/'+$routeParams.id).success(function(data){
    $scope.job = data['body'];
    md_content = $scope.job.description
    $scope.html_content = markdown.toHTML( md_content );
    $("markout").innerHTML = $scope.html_content
  });

  get_candidates = function(){
    $http.get('api/jobs/' + $routeParams.id + '/candidates').success(function(data){
      $scope.candidates = data['body'];
    });
  };

  get_candidates()

  $scope.create_candidate = function(){
    console.log($scope.candidate)
    $http.post('/api/jobs/' + $scope.job.id + '/candidates', {candidate: $scope.candidate}).
    success(function(data, status, headers, config) {
      $scope.rezultat = data;
      get_candidates();
  }).
    error(function(data, status, headers, config) {
      $scope.rezultat = data;
    });
  }

  $scope.delete_job = function(id){
    $http.delete('/api/jobs/' + $routeParams.id).success(function(data){
      window.location.replace("/user_tkw/jobs");
    });
  };
});
