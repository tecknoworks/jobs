app.controller('UserTKWJobsNewController', function ($scope, $http, $routeParams) {

  $scope.statusHash = getJobStatusHash();

  $scope.keys = Object.keys($scope.statusHash)

  function Editor(title, input, preview) {
    this.update = function () {
      title.value = setTitle(input);

      preview.innerHTML = markdown.toHTML(input.value);
    };
    input.editor = this;
    this.update();
  }

  new Editor($("title-output"), $("text-input"), $("markout"));

  $scope.create = function(){
    $http.post('/api/jobs' + generateUrlKey(), {job: {description: $("text-input").value, status: $scope.statusHash[$scope.select]}}).
    success(function(data, status, headers, config) {
      window.location.href = "/user_tkw/jobs/" + data['body']['id'];
    }).
    error(function(data, status, headers, config) {
      logged(data);
    });
  }

});
