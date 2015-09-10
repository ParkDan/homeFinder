angular.module('app.exampleApp').factory('housing_details', ['$http', function($http){
    var format = function(addresses) {
        return $http.post('/format_addresses', {addresses: addresses});
    };

    var build = function(formatted_addresses) {
        return $http.post('/build_addresses', {formatted_addresses: formatted_addresses});
    };

    return {build: build, format: format };
}]);
