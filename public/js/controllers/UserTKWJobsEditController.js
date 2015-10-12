app.controller('UserTKWJobsEditController', function ($scope, $http, $routeParams) {

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

  $scope.saveJob = function(){
    $http.put('/api/jobs/' + $scope.job.id + generateUrlKey(), {job: {description: $("text-input").value, status: $scope.statusHash[$scope.select]}}).
    success(function(data, status, headers, config) {
    }).
    error(function(data, status, headers, config) {
      logged(data)
    });
  }

  $scope.deleteJob = function(){
    $http.delete('/api/jobs/' + $scope.job.id + generateUrlKey()).
    success(function(data){
      window.location.replace("/user_tkw/jobs");
    }).
    error(function(data){
      logged(data);
    });
  };

  autoSave = function (){
    $scope.saveJob();
    setTimeout(autoSave, 3000);
  };

  $http.get('/api/jobs/' + $routeParams.id + generateUrlKey()).
  success(function(data, status, headers, config){
    $scope.job = data['body']
    $scope.select = $scope.keys[$scope.job.status]
    $scope.status = $scope.job.status

    $("text-input").value = $scope.job.description
    new Editor($("title-output"), $("text-input"), $("markout"));
    autoSave();
  }).
  error(function(data){
    logged(data)
  })

});
