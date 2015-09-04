app.controller('UserTKWJobsEditController', function ($scope, $http, $routeParams) {

  $scope.status_array = {
    'DRAFT': 0,
    'PUBLISHED': 1,
    'FILLED': 2,
    'EXPIRED': 3,
    'DASHBOARD': 4
  };

  $scope.keys = Object.keys($scope.status_array)

  function Editor(title, input, preview) {
    this.update = function () {
      var title_description = input.value.split('\n')[0]
      last = title_description.replace(/[^0-9a-z \-\_\.\,]/i, '')
      while(last != title_description){
        title_description = last
        last = title_description.replace(/[^0-9a-z \-\_\.\,]/i, '');
      };
      title.value = title_description;

      preview.innerHTML = markdown.toHTML(input.value);
    };
    input.editor = this;
    this.update();
  }

  $http.get('/api/jobs/'+$routeParams.id).
  success(function(data,status,headers, config){
    $scope.job = data['body']
    //select status
    $scope.select = $scope.keys[$scope.job.status]
    $scope.status = $scope.job.status
    //put the description in texture
    $("text-input").value = $scope.job.description
    new Editor($("title-output"), $("text-input"), $("markout"));
  });

  $scope.save = function(){
    $http.put('/api/jobs/' + $scope.job.id, {job: {description: $("text-input").value, status: $scope.status_array[$scope.select]}}).
    success(function(data, status, headers, config) {
      $scope.rezultat = data;
      window.location.replace("/user_tkw/jobs/"+data['body']['id']);
    }).
    error(function(data, status, headers, config) {
      $scope.rezultat = data;
    });
  }
});
