(function () {
  'use strict';
  var hex = angular.module('hex');

  hex.controller('HomeController', ['$scope', function ($scope) {
    $scope.message = 'Welcome to Hex!';
  }]);
}());
