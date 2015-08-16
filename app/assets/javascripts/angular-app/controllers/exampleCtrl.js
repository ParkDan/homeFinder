angular.module('app.exampleApp').controller("ExampleCtrl", [
  '$scope', 'housing_details', function($scope, housing_details) {
    $scope.tableDisplayed = false;

    $scope.search = function(){
    	$scope.results = [];
    	housing_details.get($scope.address1, $scope.address2).then(function(response) {
            response.data.forEach(function(dataSet) {
        	   $scope.results.push(dataSet.searchresults.response.results.result);
            })
			$scope.tableDisplayed = true;
        }, function(response) {
            $scope.tableDisplayed = false;
        	$scope.error = response.data.error;
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
