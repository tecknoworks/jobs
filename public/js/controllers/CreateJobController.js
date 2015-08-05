app.controller('CreateJobController', function ($scope, $http, $routeParams) {

  function Editor(input, preview) {
    this.update = function () {
      preview.innerHTML = markdown.toHTML(input.value);
    };
    input.editor = this;
    this.update();
  }

  new Editor($("text-input"), $("markout"));

});
