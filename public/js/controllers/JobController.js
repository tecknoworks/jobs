app.controller('JobController', function ($scope, $http, $routeParams) {

	$scope.job = {};
	$scope.attachments = [];
	$scope.attach = {};

	$http.get('api/jobclient/' + $routeParams.id).success(function(data){
		$scope.job = data['body'];
		md_content = $scope.job.description
		$scope.html_content = markdown.toHTML( md_content );
		$scope.posted = moment($scope.job.posted_at, "YYYYMMDD").fromNow();
		$("markout").innerHTML = $scope.html_content

	$scope.exportToPdf = function(){
		var doc = new jsPDF();

		doc.fromHTML(
		  $scope.html_content,
		  15,
		  15,
		  {
			    'width': 180
		  }
		);
		doc.output("dataurlnewwindow");
		};
	});
});
