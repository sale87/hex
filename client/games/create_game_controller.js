(function () {
    var hex = angular.module('hex');

    hex.controller('CreateGameController', ['$scope', 'Game', '$location', function ($scope, Game, $location) {
        $scope.createGame = function () {
            var game = new Game({
                description: $scope.createGameForm.description,
                time_per_move: $scope.createGameForm.timePerMove
            });
            game.$save(function (response) {
                $location.path('/games');
            });
        }
    }]);
})();
