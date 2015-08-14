angular.module('app.exampleApp').factory('housing_details', ['$http', function($http){
    var get = function(address1, address2) {
        return $http.get('/housing_details', {params: {address1: address1, address2: address2}});
    };

    return { get: get };
}]);
