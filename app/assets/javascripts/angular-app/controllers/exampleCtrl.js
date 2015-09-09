angular.module('app.exampleApp').controller("ExampleCtrl", [
  '$scope', 'housing_details', function($scope, housing_details) {
    $scope.tableDisplayed = false;
    $scope.disableBtn = false
    $scope.date = new Date();

    $scope.search = function(){
        $scope.disableBtn = true
    	housing_details.update($scope.addresses).then(function(response) {
            $scope.results = response.data
			$scope.tableDisplayed = true;
            $scope.disableBtn = false;
        }, function(response) {
            $scope.tableDisplayed = false;
        	$scope.error = response.data.error;
            $scope.disableBtn = false;
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
