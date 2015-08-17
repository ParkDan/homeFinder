angular.module('app.exampleApp').factory('housing_details', ['$http', function($http){
    var get = function(addresses) {
        return $http.get('/housing_details', {params: {addresses: addresses}});
    };

    return { get: get };
}]);
