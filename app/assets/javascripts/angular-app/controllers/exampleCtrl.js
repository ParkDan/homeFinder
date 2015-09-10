angular.module('app.exampleApp').controller("ExampleCtrl", [
  '$scope', 'housing_details', function($scope, housing_details) {
    $scope.tableDisplayed = false;
    $scope.disableBtn = false
    $scope.date = new Date();
    $scope.listings = [];
    $scope.errors = [];

    Array.prototype.chunk = function(chunkSize) {
        var array=this;
        return [].concat.apply([],
            array.map(function(elem,i) {
                return i%chunkSize ? [] : [array.slice(i,i+chunkSize)];
            })
        );
    };

    function flatten(arr) {
        return arr.reduce(function (flat, toFlatten) {
        return flat.concat(Array.isArray(toFlatten) ? flatten(toFlatten) : toFlatten);
        }, []);
    }

    $scope.search = function(){
        $scope.listings = [];
        $scope.disableBtn = true

        housing_details.format($scope.addresses).then(function(response) {
            $scope.formatted_addresses = response.data;
        }, function(response) {
            $scope.errors.push(response.data.error);
        })
        .then(function(data) {
            $scope.formatted_addresses.chunk(30).forEach(function(formatted_addresses) {
            	housing_details.build(formatted_addresses).then(function(response) {
                    $scope.listings.push(response.data);
                    $scope.listings = flatten($scope.listings)
        			$scope.tableDisplayed = true;
                    $scope.disableBtn = $scope.formatted_addresses.length > $scope.listings.length
                }, function(response) {
                    $scope.errors.push(response.data.error);
                });
            });
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
