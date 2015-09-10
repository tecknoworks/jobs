app.controller('UserTKWJobsNewController', function ($scope, $http, $routeParams) {

  $scope.status_hash = get_job_status_hash();

  $scope.keys = Object.keys($scope.status_hash)
  
  function Editor(title, input, preview) {
    this.update = function () {
      title.value = set_title(input);

      preview.innerHTML = markdown.toHTML(input.value);
    };
    input.editor = this;
    this.update();
  }

  new Editor($("title-output"), $("text-input"), $("markout"));

  $scope.create = function(){
    $http.post('/api/jobs' + generate_url_key(), {job: {description: $("text-input").value, status: $scope.status_hash[$scope.select]}}).
    success(function(data, status, headers, config) {
      window.location.replace("/user_tkw/jobs/" + data['body']['id']);
    }).
    error(function(data, status, headers, config) {
      logged(data);
    });
  }

});
