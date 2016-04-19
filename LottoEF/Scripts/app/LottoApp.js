/// <reference path='../angular-route.min.js' />
/// <reference path='../angular-resource.min.js' />
/// <reference path='../angular.min.js' />

'use restrict';

var LottoApp = angular.module('LottoApp', ['ngRoute', 'ngResource'])
.config(function ($routeProvider, $locationProvider) {
    $routeProvider
    .when('/', {
        templateUrl: 'Templates/ShowAllNumbers.html',
        controller: 'homeController'
    })
    .when('/ShowAllNumbers', {
        templateUrl: 'Templates/ShowAllNumbers.html',
        controller: 'homeController'
    })
   
    .when('/Distances', {
        templateUrl: 'Templates/Distances.html',
        //controller: 'homeController'
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

.controller('homeController', ['$scope', '$rootScope', '$log', '$location', 'Lotto', 'superCache', function ($scope, $rootScope, $log, $location, Lotto, superCache) {

    $scope.error = '';

    $scope.startDraws = [1, 200, 300, 1000, 1500, 2000, 2100, 2200, 2300, 2400, 2500, 2550, 2600, 2700, 2800, 2900, 3000, 3300];
    $scope.lottos = [{ "id": 0, "name": 'Lottery' },
                     { "id": 1, "name": 'LottoMax' },
                     { "id": 2, "name": 'BC49' }];

    $scope.lottoId = superCache.get('LottoId') != undefined ? superCache.get('LottoId') : $scope.lottos[2].id;

    $scope.numberStatistics = [{ "id": 1, "name": 'Lotto Distances' },
                               { "id": 2, "name": 'Show All Numbers' },
                              ];
    $scope.selectedNumberStat = superCache.get('SelectedNumberStat') != undefined ? superCache.get('SelectedNumberStat') : $scope.numberStatistics[1].id;

    $scope.selectedStart = superCache.get('RangeSelected') != undefined ? superCache.get('RangeSelected') : $scope.startDraws[10];
    $rootScope.selectedFreqStart = superCache.get('FrequencySelected') != undefined ? superCache.get('FrequencySelected') : $scope.startDraws[10];

    $scope.statistics = [{ "id": 1, "name": 'Natural Number Order (1..49)' },
                         { "id": 2, "name": 'Frequency Ascending Order (Left to Right)' },
                         { "id": 3, "name": 'Frequency Descending Order (Left to Right)' }];

    $scope.selectedStat = superCache.get('selectedStat') != undefined ? superCache.get('selectedStat') : $scope.statistics[0].id;

    $scope.distanceCols = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    $scope.currentSelected = 1;
    //$scope.lottoId = superCache.get('LottoId') != undefined ? superCache.get('LottoId') : 2;
    $scope.setSelection = function(value, id)
    {      
        $scope.currentSelected = value;       
        $scope.lottoId = id;
        if ($scope.lottoId == 1) // LottoMax
        {
            $scope.startDraws = 1;
            $rootScope.selectedFreqStart = 1;
        }
    }

    var successCallBack = function (response) {
        $scope.error = '';
        $rootScope.rows = response;
        superCache.put('RangeSelected', $scope.selectedStart);
        superCache.put('RangeData', $rootScope.rows);
        superCache.put('LottoId', $scope.lottoId);
        superCache.put('SelectedNumberStat', $scope.selectedNumberStat);

        $scope.loading = false;
        //$log.info(response);
    }

    var successCallBackOnFrequency = function (response) {
        $scope.error = '';
        $rootScope.rows = response;
        superCache.put('FrequencySelected', $rootScope.selectedFreqStart);
        superCache.put('FrequencyData', $rootScope.rows);
        superCache.put('SelectedNumberStat', $scope.selectedNumberStat);
        $scope.loading = false;
        //$log.info(response);
    }

    var errorCallBack = function (reason) {
        $scope.error = reason.data;
        $log.info(reason);
    }

    $scope.getRange = function (lottoId, selectedStart) {
        $scope.loading = true;
        if ($scope.lottoId == 1 && selectedStart > 1000) // LottoMax
            selectedStart = 1;
        if ($scope.selectedNumberStat == 1)
        {
            $scope.getDistances($scope.selectedNumberStat);
        }
        if ($scope.selectedStat == 1) {
            
            if (superCache.get('LottoId') == lottoId &&
                superCache.get('RangeSelected') == selectedStart &&
                superCache.get('selectedStat') == 1) {
                $rootScope.rows = superCache.get('RangeData');
                $scope.loading = false;

            }
            else {
                Lotto.getByRange({ lottoId: lottoId, startDrawNo: selectedStart })
                .$promise.then(successCallBack, errorCallBack);
                superCache.put('selectedStat', 1);
            }
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
        $location.url('/');
    }

    $scope.getDistances = function (selectedNumberStat)
    {
        if ($scope.lottoId == 1 && $scope.selectedStart > 1000)
            $scope.selectedStart = 1;
        if (selectedNumberStat == 1) { // Lotto Distances
            if (superCache.get('LottoId') == $scope.lottoId &&
                superCache.get('RangeSelected') == $scope.selectedStart &&
                superCache.get('SelectedNumberStat') == selectedNumberStat) {
                $rootScope.rows = superCache.get('FrequencyData');

            }
            else {
                $scope.loading = true;               
                Lotto.getByDistance({ lottoId: $scope.lottoId, startDrawNo: $scope.selectedStart, flag: 1 })
                    .$promise.then(successCallBackOnFrequency, errorCallBack);
            }
            $location.url('/Distances');
        }
        else if (selectedNumberStat == 2) { // Show all numbers
            $scope.getRange($scope.lottoId, $scope.selectedStart);
        }
    }

}])
