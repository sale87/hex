(function(){
    var hex = angular.module('hex');
    
    hex.factory('Game', ['$resource', function ($resource) {
        return $resource('/api/games/:id/:action', {action: ''}, {
            'accept': {method: 'POST', action: 'accept', isArray: false},
            'resign': {method: 'POST', action: 'resign', isArray: false}
        })
    }]);
})();
