app.controller('LoginController', function ($scope, $http, $routeParams) {
  $scope.user = {};
  $scope.message = '';

  $scope.login = function(){
    $http.put('api/login', {user: $scope.user}).success(function(data){
      $scope.candidate = data['body'];
      window.location.replace("/user_tkw/jobs");
    }).
    error(function(data, status, headers, config) {
      $scope.message = 'Email or password are incorrect!';
    });
  }
});
