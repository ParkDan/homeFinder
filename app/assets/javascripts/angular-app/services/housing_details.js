angular.module('app.exampleApp').factory('housing_details', ['$http', function($http){
    var update = function(addresses) {
        return $http.post('/build_addresses', {addresses: addresses});
    };
    return {update: update };
}]);
