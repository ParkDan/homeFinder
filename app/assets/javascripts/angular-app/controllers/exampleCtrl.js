angular.module('app.exampleApp').controller("ExampleCtrl", [
  '$scope', 'housing_details', function($scope, housing_details) {
    $scope.tableDisplayed = false;

    $scope.search = function(){
    	$scope.results = [];
    	housing_details.get($scope.address1, $scope.address2).then(function(response) {
            console.log(response);
        	$scope.results.push(response.data.searchresults.response.results.result);
        	console.log($scope.results[0]);
    			$scope.tableDisplayed = true;
        }, function(response) {
            $scope.tableDisplayed = false;
        	$scope.error = "You have an invalid address.";
        });
    }

    $scope.clearErrors = function(){
    	$scope.error = null;
    }

    $scope.exportData = function(fileName) {
        var htmlString = document.getElementById('exportable').innerHTML;
        var table = [htmlString.replace(/<input [^>]*>/g, '')];
        var blob = new Blob(table, {
            type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;"
        });
        saveAs(blob, fileName + ".xls");
    }

  }
]);
