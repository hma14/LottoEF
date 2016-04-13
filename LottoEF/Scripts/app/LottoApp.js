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
    .when('/Distances', {
        templateUrl: 'Templates/Distances.html',
        controller: 'homeController'
    })
    .otherwise({
        redirestTo: '/'
    })
    $locationProvider.html5Mode(true);
})
.factory('Lotto', ['$resource', function ($resource) {
    return $resource('api/tblNumberInfoes/:id', { lottoId: '@lottoId', startDrawNo: '@startDrawNo', isDesc: '@isDesc', flag: '@flag' }, {
        get: { method: 'GET', cache: true, isArray: true },
        getById: { method: 'GET', cache: true, url: 'api/tblNumberInfoes/5', isArray: true },
        getByRange: { method: 'GET', cache: true, url: 'api/tblNumberInfoes?lottoId=:lottoId&startDrawNo=:startDrawNo', isArray: true },
        getByFrequncy: { method: 'GET', cache: true, url: 'api/tblNumberInfoes?lottoId=:lottoId&startDrawNo=:startDrawNo&isDesc=:isDesc', isArray: true },
        getByDistance: { method: 'GET', cache: true, url: 'api/tblNumberInfoes?lottoId=:lottoId&startDrawNo=:startDrawNo&flag=:flag', isArray: true },
    })
}])

.controller('homeController', ['$scope', '$rootScope', '$log', 'Lotto', '$timeout', function ($scope, $rootScope, $log, Lotto, $timeout) {
    $scope.BC49 = [];
    $scope.error = '';
    $scope.rows = [];

    $scope.startDraws = [1000, 1500, 2000, 2100, 2200, 2300, 2400, 2500, 2550, 2600, 2700, 2800, 2900, 3000];
    $scope.selectedStart = $scope.startDraws[7]; // default selection

    $scope.statistics = [{ "id": 1, "name": 'Natural Number Order (1..49)' },
                         { "id": 2, "name": 'Frequncy Ascending Order (Left to Right)' },
                         { "id": 3, "name": 'Frequncy Descending Order (Left to Right)' }];
    $scope.selectedStat = $scope.statistics[0].id; // default selection

    $scope.distanceCols = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

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
        if ($scope.selectedStat == 1) {
            Lotto.getByRange({ lottoId: lottoId, startDrawNo: selectedStart })
            .$promise.then(successCallBack, errorCallBack);
        }
        else if ($scope.selectedStat == 2) {
            Lotto.getByFrequncy({ lottoId: lottoId, startDrawNo: selectedStart, isDesc: false })
            .$promise.then(successCallBack, errorCallBack);
        }
        else {
            Lotto.getByFrequncy({ lottoId: lottoId, startDrawNo: selectedStart, isDesc: true })
                .$promise.then(successCallBack, errorCallBack);
        }
    }

    $rootScope.getDistances = function (lottoId, selectedStart)
    {
        $scope.loading = true;
        Lotto.getByDistance({ lottoId: lottoId, startDrawNo: selectedStart, flag: 1 })
            .$promise.then(successCallBack, errorCallBack);
    }

}])
