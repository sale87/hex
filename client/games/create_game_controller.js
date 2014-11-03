(function () {
    var hex = angular.module('hex');

    hex.controller('CreateGameController', ['$scope', 'Game', '$location', function ($scope, Game, $location) {
        $scope.createGameFrom = {};

        $scope.createGame = function () {
            var game = new Game({
                description: $scope.createGameFrom.description,
                time_per_move: $scope.createGameFrom.timePerMove
            });
            game.$save(function (response) {
                $location.redirectTo('/games')
            });
        }
    }]);
})();
