/// <reference path='../angular-route.min.js' />
/// <reference path='../angular-resource.min.js' />
/// <reference path='../angular.min.js' />

'use restrict';

var LottoApp = angular.module('LottoApp', ['ngRoute', 'ngResource'])
.config(function ($routeProvider, $locationProvider) {
    $routeProvider
    .when('/', {
        templateUrl: 'Templates/BC49.html',
        controller: 'homeController'
    })
    .when('/BC49', {
        templateUrl: 'Templates/BC49.html',
        controller: 'homeController'
    })
    .otherwise({
        redirestTo: '/'
    })
    $locationProvider.html5Mode(true);
})
.factory('Lotto', ['$resource', function ($resource) {
    return $resource('api/tblNumberInfoes/:id', { lottoId: '@lottoId', startDrawNo: '@startDrawNo' }, {
        get: { method: 'GET', cache: true, isArray: true },
        getById: { method: 'GET', cache: true, url: 'api/tblNumberInfoes/5', isArray: true },
        getByRange: { method: 'GET', cache: true, url: 'api/tblNumberInfoes?lottoId=:lottoId&startDrawNo=:startDrawNo', isArray: true },
    })
}])
.controller('homeController', ['$scope', '$log', 'Lotto', '$timeout', function ($scope, $log, Lotto, $timeout) {
    $scope.BC49 = [];
    $scope.error = '';
    $scope.rows = [];

    $scope.startDraws = [1000, 1500, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000];
    $scope.selectedStart = $scope.startDraws[7]; // default selection


    var successCallBack = function (response) {
        $scope.error = '';       
        $scope.rows = response;
        $scope.loading = false;
        //$log.info(response);
    }
    var errorCallBack = function (reason) {
        $scope.error = reason.data;
        $log.info(reason);
    }

    $scope.getRange = function (lottoId, selectedStart) {
        $scope.loading = true;
        Lotto.getByRange({ lottoId: lottoId, startDrawNo: selectedStart })
        .$promise.then(successCallBack, errorCallBack);

    }

}])
