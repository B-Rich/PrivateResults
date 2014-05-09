window.PrivateResults = window.PrivateResults || angular.module('PrivateResults', []);

window.PrivateResults.controller('InfectionActivityTimelinesController', function ($scope, $http) {
  $http({
    url: '/api/infection_activity_timelines',
    method: 'GET',
    params: {'infection': 'HIV', 'from': '2010-01-01', 'to': '2010-01-31'}
  })
    .success(function (data, status) {
      $scope.status = undefined;
      $scope.data = data;
    })
    .error(function (data, status) {
      $scope.status = status;
      $scope.data = data || [];
    });
});
