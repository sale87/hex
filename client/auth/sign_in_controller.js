(function () {
  'use strict';
  var hex = angular.module('hex');

  hex.controller('SignInController', ['$scope', function ($scope) {
    $scope.$on('auth:login-error', function (ev, reason) {
      $scope.error = reason.errors[0];
    });
  }]);
}());
