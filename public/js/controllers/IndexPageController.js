app.controller('IndexPageController', function ($scope, $http) {

	$scope.jobs = 'asd';

	$scope.get_jobs = function(){
			$http.get('jobs').success(function(data){
				$scope.jobs = data['body'];
				$scope.number_of_jobs = $scope.jobs.length;
			});
	}

	$scope.get_jobs()

});
