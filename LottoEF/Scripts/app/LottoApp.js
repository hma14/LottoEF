/// <reference path='../angular-route.min.js' />
/// <reference path='../angular-resource.min.js' />
/// <reference path='../angular.min.js' />

'use restrict';

var LottoApp = angular.module('LottoApp', ['ngRoute', 'ngResource'])
.config(function($routeProvider, $locationProvider){
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
        redirestTo:'/'
    })
    $locationProvider.html5Mode(true);
})
.factory('BC49', ['$resource', function ($resource) {
    return $resource('api/BC49/:id', {start: '@start'}, {
        get: {method:'GET', cache:true, isArray:true},
        getById: { method: 'GET', cache: true, url: 'api/BC49/5', isArray: true },
        getByRange: { method: 'GET', cache: true, url: 'api/BC49?start=:start', isArray: true },
    })
}])
.controller('homeController', ['$scope', '$log',  'BC49',  function ($scope, $log, BC49) {
    $scope.BC49 = [];
    $scope.error = '';
    $scope.drawNumber = 2000;

    $scope.startDraws = [1000, 1500, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000];

    var successCallBack = function(response)
    {
        $scope.BC49 = response;
        $log.info(response);
    }
    var errorCallBack = function(reason)
    {
        $scope.error = reason.data;
        $log.info(reason);
    }

    $scope.init = function()
    {
        BC49.get().$promise.then(successCallBack, errorCallBack);
    }
    
    $scope.getRange = function (selectedStart)
    {
        BC49.getByRange({ start: selectedStart })
        .$promise.then(successCallBack, errorCallBack);
    }
        
}])
