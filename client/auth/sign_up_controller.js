(function () {
  'use strict';
  var hex = angular.module('hex');

  hex.controller('SignUpController', ['$scope', '$auth', function ($scope, $auth) {
    $scope.register = function () {
      $auth.submitRegistration($scope.registrationForm)
        .then(function () {
          $auth.submitLogin({
            email: $scope.registrationForm.email,
            password: $scope.registrationForm.password
          });
        });
    };
  }]);
}());