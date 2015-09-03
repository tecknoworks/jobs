app.controller('UserTKWJobsNewController', function ($scope, $http, $routeParams) {
  function Editor(input, preview) {
    this.update = function () {
      preview.innerHTML = markdown.toHTML(input.value);
    };
    input.editor = this;
    this.update();
  }

  new Editor($("text-input"), $("markout"));

  $scope.status = 0;

  $scope.create = function(){
    $http.post('/api/jobs', {job: {description: $("text-input").value, status: $scope.status}}).
      success(function(data, status, headers, config) {
        $scope.rezultat = data;
        window.location.replace("/user_tkw/jobs/"+data['body']['id']);
      }).
      error(function(data, status, headers, config) {
        $scope.rezultat = data;
      });
  }
});
