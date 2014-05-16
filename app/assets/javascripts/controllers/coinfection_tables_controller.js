console.log("CoinfectionTablesController");

angular.module('PrivateResults').controller('CoinfectionTablesController', function ($scope, $http) {
  $http({ url: '/api/coinfection_tables', method: 'GET' })
    .success(function (data, status) {
      $scope.infection_names = Object.keys(data).sort();
      $scope.coinfection_rows = data;

      console.log($scope.coinfection_rows);
      console.log($scope.infection_names);
    })
    .error(function (data, status) {});

  $scope.row_values = function row_values(infection_name) {
    var coinfection_row = $scope.coinfection_rows[infection_name];

    return $scope.infection_names.map(function (name) {
      return coinfection_row[name];
    });
  };
});
