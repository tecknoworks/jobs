app.controller('UserTKWJobsNewController', function ($scope, $http, $routeParams) {

  $scope.status_hash = {
    'DRAFT': 0,
    'PUBLISHED': 1,
    'FILLED': 2,
    'EXPIRED': 3,
    'DASHBOARD': 4
  };

  $scope.keys = Object.keys($scope.status_hash)
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

  new Editor($("title-output"), $("text-input"), $("markout"));

  $scope.status = 0;

  $scope.create = function(){
    $http.post('/api/jobs' + generate_url_key(), {job: {description: $("text-input").value, status: $scope.status_hash[$scope.select]}}).
    success(function(data, status, headers, config) {
      $scope.rezultat = data;
      window.location.replace("/user_tkw/jobs/"+data['body']['id']);
    }).
    error(function(data, status, headers, config) {
      logged(data);
    });
  }

});
