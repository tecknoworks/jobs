app.controller('LoginController', function ($scope, $http, $routeParams) {
  $scope.user = {};
  $scope.message = '';

  $http.get('/api/logged/' + Cookies.get('key_id') + generate_url_key()).
  success(function(data){
    console.log(data['code'])
    window.location.replace('/user_tkw/jobs');
  }).
  error(function(data){
    console.log(data['code'])
  });

  $scope.login = function(){
    $http.put('api/login', {user: $scope.user}).
    success(function(data){
      key = data['body'];
      Cookies.set('consumer_key', key['consumer_key']);
      Cookies.set('secret_key', key['secret_key']);
      Cookies.set('key_id', key['id']);
      Cookies.set('user_id', key['user_id']);
      window.location.replace("/user_tkw/jobs");
    }).
    error(function(data, status, headers, config) {
      $scope.message = 'Email or password are incorrect!';
    });
  }
});
