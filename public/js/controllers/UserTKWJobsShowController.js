app.controller('UserTKWJobsShowController', function ($scope, $http, $routeParams) {
  $scope.job = {};
  $scope.attachments = [];
  $scope.attach = {};

  $http.get('api/jobs/'+$routeParams.id).success(function(data){
    $scope.job = data['body'];
    md_content = $scope.job.description
    $scope.html_content = markdown.toHTML( md_content );
    $("markout").innerHTML = $scope.html_content
  });

  $scope.delete_job = function(id){
    $http.delete('/api/jobs/' + $routeParams.id).success(function(data){
      window.location.replace("/user_tkw/jobs");
    });
  };
});
