console.log("InfectionTrendsController");

angular.module('PrivateResults').controller('InfectionTrendsController', function ($scope, $http, $log) {
  $http({
    url: '/api/infection_trends',
    method: 'GET',
    params: {'from': '2010-01-01', 'to': '2010-12-31'}
  })
    .success(function infection_trend_success(data, status) {
      "use strict";
      var date_hash = {}, date_keys, infection_names = Object.keys(data);

      $log.info("Infection trend AJAX request status", status);
      infection_names.forEach(function (infection_name) {
        $log.info("Processing", infection_name);

        Object.keys(data[infection_name]).forEach(function (date) {
          date_hash[date] = 1;
        });
      });

      date_keys = Object.keys(date_hash).sort();
      $log.info(["Extracted", date_keys.length, "trend dates"].join(' '));

      $scope.infection_trend_data = date_keys.map(function (date_string) {
        var entry = {date: new Date(date_string)};

        infection_names.forEach(function (infection_name) {
          var key = [infection_name, "positive"].join('_');
          entry[key] = data[infection_name][date_string] || 0;
        });

        return entry;
      });

      $scope.infection_trend_options = {
        lineMode: 'linear',
        series: [
          {y: 'HIV_positive', label: 'HIV', type: 'line', color: '#e72510'},
          {y: 'Trichomoniasis_positive', label: 'Trichomoniasis', type: 'line', color: '#02a5de'},
          {y: 'Gonorrhea_positive', label: 'Gonorrhea', type: 'line', color: '#a54caa'},
          {y: 'Syphilis_positive', label: 'Syphilis', type: 'line', color: '#e08b27'},
          {y: 'Chlamydia_positive', label: 'Chlamydia', type: 'line', color: '#4da309'}
        ],
        axes: {x:
               {key: "date",
                labelFunction: function (date) {
                 return moment(date).format('MMM');//.setDate(01);
                },
                tooltipFormatter: function (d) {
                  return moment(d).format('YYYY-MM-DD');
                }
               },
               y: { key: 'Positive Results' }
              },
        tension: 0.7
      };
    })
    .error(function (data, status) {
      $scope.status = status;
      $log.error("Error loading infection trends: " + status);
    });
});
