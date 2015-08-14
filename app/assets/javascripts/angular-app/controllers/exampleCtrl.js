angular.module('app.exampleApp').controller("ExampleCtrl", [
  '$scope', 'housing_details', function($scope, housing_details) {
    $scope.tableDisplayed = false;

    $scope.search = function(){
    	$scope.results = [];
    	housing_details.get($scope.address1, $scope.address2).then(function(response) {
        	$scope.results.push(response.data.searchresults.response.results.result);
        	console.log($scope.results[0]);
    			$scope.tableDisplayed = true;
        }, function(response) {
        	$scope.error = "You have an invalid address.";
        });
    }

    $scope.clearErrors = function(){
    	$scope.error = null;
    }

  }
]);
