app.controller('LoginController', function ($scope, $http, $routeParams) {
  $scope.user = {};
  $scope.message = '';

  $http.get('/api/logged/' + Cookies.get('key_id') + generateUrlKey()).
  success(function(data){
    console.log(data['code'])
    window.location.replace('/user_tkw/jobs');
  }).
  error(function(data){
    console.log(data['code'])
  });

  $scope.login = function(){
    $http.put('/api/login', {user: $scope.user}).
    success(function(data){
      key = data['body'];
      setCookie(key)
      window.location.replace("/user_tkw/jobs");
    }).
    error(function(data, status, headers, config) {
      $scope.message = 'Email or password are incorrect!';
    });
  }
});
