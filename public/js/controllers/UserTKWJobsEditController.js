app.controller('UserTKWJobsEditController', function ($scope, $http, $routeParams) {

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

  $http.get('/api/jobs/' + $routeParams.id + generate_url_key()).
  success(function(data,status,headers, config){
    $scope.job = data['body']
    $scope.select = $scope.keys[$scope.job.status]
    $scope.status = $scope.job.status

    $("text-input").value = $scope.job.description
    new Editor($("title-output"), $("text-input"), $("markout"));
  }).
  error(function(data){
    logged(data)
  })

  $scope.save_job = function(){
    $http.put('/api/jobs/' + $scope.job.id + generate_url_key(), {job: {description: $("text-input").value, status: $scope.status_hash[$scope.select]}}).
    success(function(data, status, headers, config) {
      window.location.replace("/user_tkw/jobs/" + data['body']['id']);
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }

  $scope.delete_job = function(){
    $http.delete('/api/jobs/' + $scope.job.id + generate_url_key()).
    success(function(data){
      window.location.replace("/user_tkw/jobs");
    }).
    error(function(data){
      logged(data);
    });
  };

});
