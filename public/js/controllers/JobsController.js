app.controller('JobsController', function ($scope, $http) {

	$scope.jobs = [];

	$scope.get_jobs = function(){
			$http.get('api/jobs').success(function(data){
				$scope.jobs = data['body'];
				$scope.number_of_jobs = $scope.jobs.length;
			});
	}

	$scope.get_jobs()

});
