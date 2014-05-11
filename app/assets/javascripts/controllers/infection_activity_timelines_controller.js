window.PrivateResults = window.PrivateResults || angular.module('PrivateResults', ['n3-pie-chart']);

window.PrivateResults.controller('InfectionActivityTimelinesController', function ($scope, $http, $log) {
  $http({
    url: '/api/infection_activity_timelines',
    method: 'GET',
    params: {'infection': 'HIV', 'from': '2010-01-01', 'to': '2010-01-31'}
  })
    .success(function (data, status) {
      $scope.status = undefined;
      $scope.data = data;

      $scope.positive_negative_pie_data = $scope.data.data.reduce(function (ary, date) {
        ary[0].value += date.results.positive;
        ary[1].value += date.results.negative;

        return ary;
      }, [
        {label: "positive", value: 0, color: "red"},
        {label: "negative", value: 0, color: "green"}
      ]);

      $scope.positive_negative_pie_options = {thickness: 10};
    })
    .error(function (data, status) {
      $scope.status = status;
      $scope.data = data || [];
    });
});
