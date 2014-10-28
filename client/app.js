(function () {
  'use strict';

  var hex = angular.module('hex', ['ui.bootstrap', 'ngRoute', 'LocalStorageModule', 'ng-token-auth']);

  hex.config(['$routeProvider', function ($routeProvider) {
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
  }]);

  hex.run(['$rootScope', '$location', function ($rootScope, $location) {
    $rootScope.$on('auth:login-success', function () {
      $location.path('/');
    });
  }]);

  hex.controller('ApplicationController', ['$scope', function ($scope) {
    $scope.message = 'Hello World!';
  }]);
}());
