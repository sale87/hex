(function () {
  var hex = angular.module('hex', ['ui.bootstrap', 'ngRoute', 'LocalStorageModule']);

  hex.controller('ApplicationController', ['$scope', function ($scope) {
    $scope.message = 'Hello World!';
  }]);
}());
