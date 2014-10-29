(function () {
  'use strict';
  var hex = angular.module('hex');

  hex.controller('SignUpController', ['$scope', '$location', '$auth', function ($scope, $location, $auth) {
    $scope.$on('auth:registration-email-error', function (ev, reason) {
      $scope.errors = [];
      _.each(reason.errors, function (errorList, field) {
        _.each(errorList, function (error) {
          if (error !== "This email address is already in use") {
            $scope.errors.push(field.charAt(0).toUpperCase() + field.slice(1) + " " + error + ".");
          }
        });
      });
    });
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
