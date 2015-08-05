app.controller('JobsController', function ($scope, $http) {

	$scope.jobs = [];

	$http.get('api/jobs').success(function(data){
		$scope.jobs = data['body'];
		$scope.number_of_jobs = $scope.jobs.length;
	});
});
