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
        getByFrequency: { method: 'GET', cache: true, url: 'api/tblNumberInfoes?lottoId=:lottoId&startDrawNo=:startDrawNo&isDesc=:isDesc', isArray: true },
        getByDistance: { method: 'GET', cache: true, url: 'api/tblNumberInfoes?lottoId=:lottoId&startDrawNo=:startDrawNo&flag=:flag', isArray: true },
    })
}])

.factory('superCache', ['$cacheFactory', function($cacheFactory) {
    return $cacheFactory('super-cache');
}])

.controller('homeController', ['$scope', '$rootScope', '$log', 'Lotto', 'superCache', function ($scope, $rootScope, $log, Lotto, superCache) {
    $scope.BC49 = [];
    $scope.error = '';
    $rootScope.rows = [];

    $scope.startDraws = [1000, 1500, 2000, 2100, 2200, 2300, 2400, 2500, 2550, 2600, 2700, 2800, 2900, 3000];
    $scope.selectedStart = superCache.get('RangeSelected') != undefined ? superCache.get('RangeSelected') : $scope.startDraws[7];
    $scope.selectedFreqStart = superCache.get('FrequencySelected') != undefined ? superCache.get('FrequencySelected') : $scope.startDraws[7];

    $scope.statistics = [{ "id": 1, "name": 'Natural Number Order (1..49)' },
                         { "id": 2, "name": 'Frequency Ascending Order (Left to Right)' },
                         { "id": 3, "name": 'Frequency Descending Order (Left to Right)' }];

    $scope.selectedStat = superCache.get('selectedStat') != undefined ? superCache.get('selectedStat') : $scope.statistics[0].id;

    $scope.distanceCols = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    $scope.currentSelected = 1;
    $scope.setSelection = function(value)
    {
        $scope.currentSelected = value;
    }

    var successCallBack = function (response) {
        $scope.error = '';
        $rootScope.rows = response;
        superCache.put('RangeSelected', $scope.selectedStart);
        superCache.put('RangeData', $rootScope.rows);
        
        $scope.loading = false;
        //$log.info(response);
    }

    var successCallBackOnFrequency = function (response) {
        $scope.error = '';
        $rootScope.rows = response;
        superCache.put('FrequencySelected', $scope.selectedFreqStart);
        superCache.put('FrequencyData', $rootScope.rows);

        $scope.loading = false;
        //$log.info(response);
    }

    var errorCallBack = function (reason) {
        $scope.error = reason.data;
        $log.info(reason);
    }

    $scope.getRange = function (lottoId, selectedStart) {
        $scope.currentSelected = 1;
        $scope.loading = true;
        if ($scope.selectedStat == 1) {
            
            if (superCache.get('RangeSelected') != undefined &&
                superCache.get('RangeSelected') == $scope.selectedStart &&
                superCache.get('selectedStat') == 1) {
                $rootScope.rows = superCache.get('RangeData');
                $scope.loading = false;
                return;
            }
            Lotto.getByRange({ lottoId: lottoId, startDrawNo: selectedStart })
            .$promise.then(successCallBack, errorCallBack);
            superCache.put('selectedStat', 1);
        }
        else if ($scope.selectedStat == 2) {
            Lotto.getByFrequency({ lottoId: lottoId, startDrawNo: selectedStart, isDesc: false })
            .$promise.then(successCallBack, errorCallBack);
            superCache.put('selectedStat', 2);
        }
        else {
            Lotto.getByFrequency({ lottoId: lottoId, startDrawNo: selectedStart, isDesc: true })
                .$promise.then(successCallBack, errorCallBack);
            superCache.put('selectedStat', 3);
        }
    }

    $scope.getDistances = function (lottoId, selectedFreqStart)
    {
        $scope.currentSelected = 2;
        if (superCache.get('FrequencySelected') != undefined && superCache.get('FrequencySelected') == selectedFreqStart) {
            $rootScope.rows = superCache.get('FrequencyData');
            return;
        }
        $scope.loading = true;
        Lotto.getByDistance({ lottoId: lottoId, startDrawNo: selectedFreqStart, flag: 1 })
            .$promise.then(successCallBackOnFrequency, errorCallBack);
    }

}])
