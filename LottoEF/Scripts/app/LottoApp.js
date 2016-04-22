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
        controller: 'homeController'
    })
    .otherwise({
        redirestTo: '/'
    })
    $locationProvider.html5Mode(true);
})
.factory('Lotto', ['$resource', function ($resource) {
    return $resource('api/tblNumberInfoes/:id', { lottoId: '@lottoId', startDrawNo: '@pastDraws', isDesc: '@isDesc', flag: '@flag' }, {
        get: { method: 'GET', cache: true, isArray: true },
        getById: { method: 'GET', cache: true, url: 'api/tblNumberInfoes/5', isArray: true },
        getByRange: { method: 'GET', cache: true, url: 'api/tblNumberInfoes?lottoId=:lottoId&pastDraws=:pastDraws', isArray: true },
        getByFrequency: { method: 'GET', cache: true, url: 'api/tblNumberInfoes?lottoId=:lottoId&pastDraws=:pastDraws&isDesc=:isDesc', isArray: true },
        getByDistance: { method: 'GET', cache: true, url: 'api/tblNumberInfoes?lottoId=:lottoId&pastDraws=:pastDraws&flag=:flag', isArray: true },
    })
}])

.factory('superCache', ['$cacheFactory', function($cacheFactory) {
    return $cacheFactory('super-cache');
}])

.controller('homeController', ['$scope', '$rootScope', '$log', '$location', 'Lotto', 'superCache', '$route', '$filter', 
    function ($scope, $rootScope, $log, $location, Lotto, superCache, $route, $filter) {

        $scope.error = '';

    $scope.pastDraws = [50, 100, 200, 300, 400, 500,600,700,800, 900, 1000];
    $scope.lottos = [{ "id": 0, "name": 'Lottery' },
                     { "id": 1, "name": 'LottoMax' },
                     { "id": 2, "name": 'BC49' }];

    $scope.lottoId = superCache.get('LottoId') != undefined ? superCache.get('LottoId') : $scope.lottos[2].id;

    $scope.numberStatistics = [{ "id": 1, "name": 'Lotto Distances' },
                               { "id": 2, "name": 'Show All Numbers' },
                              ];
    $scope.selectedNumberStat = superCache.get('SelectedNumberStat') != undefined ? superCache.get('SelectedNumberStat') : $scope.numberStatistics[1].id;

    $scope.selectedPastDraws = superCache.get('RangeSelected') != undefined ? superCache.get('RangeSelected') : $scope.pastDraws[1];
    $rootScope.selectedFreqStart = superCache.get('FrequencySelected') != undefined ? superCache.get('FrequencySelected') : $scope.pastDraws[1];

    $scope.statistics = [{ "id": 1, "name": 'Natural Number Order (1..49)' },
                         { "id": 2, "name": 'Frequency Ascending Order (Left to Right)' },
                         { "id": 3, "name": 'Frequency Descending Order (Left to Right)' }];

    $scope.selectedStat = superCache.get('selectedStat') != undefined ? superCache.get('selectedStat') : $scope.statistics[0].id;

    $scope.distanceCols = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    $scope.currentSelected = 1;
   
    var successCallBack = function (response) {
        $scope.error = '';
        var startTime = new Date();
        $rootScope.rows = response;
        superCache.put('RangeSelected', $scope.selectedPastDraws);
        superCache.put('RangeData', $rootScope.rows);
        superCache.put('LottoId', $scope.lottoId);
        superCache.put('SelectedNumberStat', $scope.selectedNumberStat);

        setTimeout(function () {
            $rootScope.ProcessTime = (new Date() - startTime) / 1000;
        }); // Leave timeout empty to fire on next tick
        $scope.loading = false;
        //$log.info(response);
    }

    var successCallBackOnFrequency = function (response) {
        $scope.error = '';
        var startTime = new Date();
        $rootScope.rows = response;
        superCache.put('FrequencySelected', $rootScope.selectedFreqStart);
        superCache.put('FrequencyData', $rootScope.rows);
        superCache.put('SelectedNumberStat', $scope.selectedNumberStat);

        setTimeout(function () {
            $rootScope.ProcessTime = (new Date() - startTime) / 1000;
        }); // Leave timeout empty to fire on next tick
        $scope.loading = false;
    }

    var errorCallBack = function (reason) {
        $scope.error = reason.data;
        $log.info(reason);
    }


    $scope.getRange = function (lottoId) {
        $scope.loading = true;
        if ($scope.lottoId == 1 && $scope.selectedPastDraws > 400) // LottoMax
            selectedPastDraws = 100;        

        if ($scope.selectedStat == 1) {
            
            if (superCache.get('LottoId') == lottoId &&
                superCache.get('RangeSelected') == $scope.selectedPastDraws &&
                superCache.get('selectedStat') == 1) {
                $rootScope.rows = superCache.get('RangeData');
                $scope.loading = false;
            }
            else {
                Lotto.getByRange({ lottoId: lottoId, pastDraws: $scope.selectedPastDraws })
                .$promise.then(successCallBack, errorCallBack);
                superCache.put('selectedStat', 1);
            }
        }
        else if ($scope.selectedStat == 2) {
            Lotto.getByFrequency({ lottoId: lottoId, pastDraws: $scope.selectedPastDraws, isDesc: false })
            .$promise.then(successCallBack, errorCallBack);
            superCache.put('selectedStat', 2);
        }
        else {
            Lotto.getByFrequency({ lottoId: lottoId, pastDraws: $scope.selectedPastDraws, isDesc: true })
                .$promise.then(successCallBack, errorCallBack);
            superCache.put('selectedStat', 3);
        }
        $location.url('/');
    }

    $scope.getDistances = function (selectedNumberStat)
    {
        $scope.loading = true;
        if ($scope.lottoId == 1 && $scope.selectedPastDraws > 400)
            $scope.selectedPastDraws = 100;
        if (selectedNumberStat == 1) { // Lotto Distances
            if (superCache.get('LottoId') == $scope.lottoId &&
                superCache.get('RangeSelected') == $scope.selectedPastDraws &&
                superCache.get('SelectedNumberStat') == selectedNumberStat) {
                $rootScope.rows = superCache.get('FrequencyData');
                $scope.loading = false;
            }
            else {
                $scope.loading = true;               
                Lotto.getByDistance({ lottoId: $scope.lottoId, pastDraws: $scope.selectedPastDraws, flag: 1 })
                    .$promise.then(successCallBackOnFrequency, errorCallBack);
            }
            $location.url('/Distances');
        }
        else if (selectedNumberStat == 2) { // // switch to Show all numbers
            $scope.getRange($scope.lottoId, $scope.selectedPastDraws);
        }
    }

}])
