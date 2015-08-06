app.controller('JobController', function ($scope, $http, $routeParams) {

	$scope.job = {};
	$scope.attachments = [];
	$scope.test = 'asd';

	$http.get('api/jobs/'+$routeParams.id).success(function(data){
		$scope.job = data['body'];
		md_content = $scope.job.description
		$scope.html_content = markdown.toHTML( md_content );
		$("markout").innerHTML = $scope.html_content
	});

	$http.get('api/jobs/'+$routeParams.id+'/attachments').success(function(data){
		$scope.attachments = data['body'];
	});

	// $scope.attach_file = function(){
	// 	// $scope.test = 'bla bla bla'
	//
	// 	// $scope.test = $_FILES['file']['name']
	// 		// $scope.test = $('fileinput').value
	// }

});
