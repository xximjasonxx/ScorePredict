'use strict';

// Declare app level module which depends on filters, and services
angular.module('app', [
  'ngRoute',
  'ui.bootstrap',
  'myApp.filters',
  'app.services',
  'app.directives',
  'app.controllers'
]).
config(['$routeProvider', '$httpProvider', function($routeProvider, $httpProvider) {
        // routing
        $routeProvider.when('/main', {templateUrl: 'views/main.html'});
        $routeProvider.when('/teams', {templateUrl: 'views/teams.html', controller: 'teamsCtrl'});
        $routeProvider.when('/weeks', {templateUrl: 'views/weeks.html', controller: 'weeksCtrl'});
        $routeProvider.when('/games/:weekNumber/:year', {templateUrl: 'views/games.html', controller: 'gamesCtrl'});
        $routeProvider.when('/games', {templateUrl: 'views/games.html', controller: 'gamesCtrl'});
        $routeProvider.when('/predictions', {templateUrl: 'views/predictions.html', controller: 'predictionsCtrl'});
        $routeProvider.otherwise({redirectTo: '/main'});

        // http
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
        $httpProvider.defaults.headers.common["X-ZUMO-MASTER"] = "YOARchNYIvYgMjuZqZJwiInXemTous96";
}]);
