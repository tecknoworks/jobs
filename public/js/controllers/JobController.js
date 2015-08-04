app.controller('JobController', function ($scope, $http, $routeParams) {

	var $ = function (id) { return document.getElementById(id); };

	$scope.job = '';

	get_job = function(){
			$http.get('jobs/'+$routeParams.id).success(function(data){
				$scope.job = data['body'];
				md_content = $scope.job.description
				$scope.html_content = markdown.toHTML( md_content );
				$("markout").innerHTML = $scope.html_content
			});
	}


	get_job()

});
