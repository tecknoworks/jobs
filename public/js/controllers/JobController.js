app.controller('JobController', function ($scope, $http, $routeParams) {

	$scope.job = {};
	$scope.attachments = [];
	$scope.test = 'asd';
	$scope.attach = {};

	$http.get('api/jobs/'+$routeParams.id).success(function(data){
		$scope.job = data['body'];
		md_content = $scope.job.description
		$scope.html_content = markdown.toHTML( md_content );
		$("markout").innerHTML = $scope.html_content
	});

	$http.get('api/jobs/'+$routeParams.id+'/attachments').success(function(data){
		$scope.attachments = data['body'];
	});

	$scope.attach_file = function(){
		$scope.attach = $('inputfile').value
		$http.post('api/jobs/'+$routeParams.id+'/attachments', {attachment: $scope.attach}).
			success(function(data, status, headers, config) {
				$scope.key = data;
			})
	}

});
