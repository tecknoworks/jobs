app.controller('JobController', function ($scope, $http, $routeParams) {

	$scope.job = {};

	$http.get('api/jobs/'+$routeParams.id).success(function(data){
		$scope.job = data['body'];
		md_content = $scope.job.description
		$scope.html_content = markdown.toHTML( md_content );
		$("markout").innerHTML = $scope.html_content
	});

});
