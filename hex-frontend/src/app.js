(function () {
  'use strict';

  var hex = angular.module('hex', ['ui.bootstrap', 'ngRoute', 'LocalStorageModule', 'ng-token-auth']);

  hex.config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: '/views/home/home.html',
        controller: 'HomeController'
      })
      .otherwise({
        redirectTo: '/'
      });
  });

  hex.controller('ApplicationController', ['$scope', function ($scope) {
    $scope.message = 'Hello World!';
  }]);
}());
