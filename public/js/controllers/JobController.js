app.controller('JobController', function ($scope, $http, $routeParams) {

	$scope.job = '';
	$scope.get_job = function(){
			$http.get('jobs/'+$routeParams.id).success(function(data){
				$scope.job = data['body'];
			});
	}

	$scope.get_job()

});
