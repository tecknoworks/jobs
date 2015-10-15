app.controller('JobsController', function ($scope, $http, $location) {

  $scope.jobs = [];

  $http.get('api/jobclient').success(function(data){
    $scope.jobs = data['body'];
    $scope.numberOfJobs = $scope.jobs.length;
  });

  $scope.posted = function(time){
    return moment(time, "YYYYMMDD").fromNow();
  }

  $scope.goTo = function (job) {
    $location.url('/jobs/' + job.id);
  }

  imagesName = ['career-business-analyst',
  'career-business-domain-expert',
  'career-data-modeller',
  'career-developer',
  'career-graphic-designer',
  'career-infrastructure-architect',
  'career-performance-tester',
  'career-project-manager',
  'career-security-tester',
  'career-support-analyst',
  'career-tech-lead',
  'career-tester',
  'career-ux-designer']

  lastNumber = -1

  function rec (){
    $scope.changeImage = function (){
      var randomNumber = Math.floor(Math.random() * 12);
      while (randomNumber == lastNumber){
        var randomNumber = Math.floor(Math.random() * 12);
      }
      lastNumber = randomNumber
      var imgName = imagesName[randomNumber] + '.jpg';
      $scope.number = imgName
      document.getElementById("imageid").src = '/img/' + imgName ;
    }
    $scope.changeImage()
    setTimeout(rec, 5000);
  }
  rec()

});
