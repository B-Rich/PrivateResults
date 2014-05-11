window.PrivateResults = window.PrivateResults || angular.module('PrivateResults', ['n3-pie-chart', 'n3-line-chart']);

window.PrivateResults.controller('InfectionActivityTimelinesController', function ($scope, $http, $log) {
  $http({
    url: '/api/infection_activity_timelines',
    method: 'GET',
    params: {'infection': 'HIV', 'from': '2010-01-01', 'to': '2010-05-31'}
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

      $scope.timeline_data = $scope.data.data
        .map(function (date) {
          var normalized_day = new Date(date.date);

          return {
            date: normalized_day,
            tests_total: date.total,
            results_total: date.results.total,
            results_positive: date.results.positive,
            results_negative: date.results.negative
          };
        })
        .sort(function (a, b) {
          if(a.date < b.date) return -1;
	  if(a.date > b.date) return 1;
	  return 0;
        });

      $scope.timeline_options = {
        lineMode: 'linear',
        series: [
          {y: 'tests_total', label: 'Total Tests', type: 'line', color: '#428bca'},
          {y: 'results_total', label: 'Total Results', type: 'line', color: '#5bc0de'},
          {y: 'results_positive', label: 'Positive', type: 'line', color: '#d9534f'},
          {y: 'results_negative', label: 'Negative', type: 'line', color: '#5cb85c'}
        ],
        axes: {x:
               {type: "date", key: "date", labelFunction: function (date) {
                 return date.setDate(01);
               }}
              },
        tension: 0.7
      };

      console.log($scope.timeline_data);
      console.log($scope.timeline_options);
    })
    .error(function (data, status) {
      $scope.status = status;
      $scope.data = data || [];
    });
});
