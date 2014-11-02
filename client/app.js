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
            }).when('/sign_up', {
                templateUrl: '/views/auth/sign_up.html',
                controller: 'SignUpController'
            }).when('/games', {
                templateUrl: '/views/games/games.html',
                controller: 'GamesController'
            }).when('/games/create', {
                templateUrl: '/views/games/create.html',
                controller: 'CreateGameController'
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
