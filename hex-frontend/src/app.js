(function () {
  'use strict';

  var hex = angular.module('hex', ['ui.bootstrap', 'ngRoute', 'LocalStorageModule', 'ng-token-auth']);

  hex.config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: '/views/home/home.html',
        controller: 'HomeController'
      }).when('/sign_in', {
        templateUrl: '/views/auth/sign_in.html',
        controller: 'SignInController'
      }).otherwise({
        redirectTo: '/'
      });
  });

  hex.config(function ($authProvider) {
    $authProvider.configure({
      apiUrl: 'http://localhost:3000'
    });
  });

  hex.controller('ApplicationController', ['$scope', function ($scope) {
    $scope.message = 'Hello World!';
  }]);
}());
