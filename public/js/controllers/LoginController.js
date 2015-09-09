app.controller('LoginController', function ($scope, $http, $routeParams) {
  $scope.user = {};
  $scope.message = '';

  $scope.login = function(){
    $http.put('api/login', {user: $scope.user}).
    success(function(data){
      $scope.key = data['body'];
      Cookies.set('consumer_key', $scope.key['consumer_key']);
      Cookies.set('secret_key', $scope.key['secret_key']);
      Cookies.set('user_id', $scope.key['user_id']);
      window.location.replace("/user_tkw/jobs");
    }).
    error(function(data, status, headers, config) {
      $scope.message = 'Email or password are incorrect!';
    });
  }
});
