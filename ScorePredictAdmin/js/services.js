'use strict';

/* Services */
angular.module('app.services', []).
    service('teamsSvc', ['$http', '$q', function($http, $q) {
        return {
            getTeams: function() {
                var deferred = $q.defer();
                $http({method: 'GET', url: 'https://scorepredict.azure-mobile.net/tables/teams'}).
                    success(function(data) {
                        deferred.resolve(data);
                    }).
                    error(function(data, status) {
                        deferred.reject(status);
                    });

                return deferred.promise;
            },

            saveTeam: function(teamId, abbr, name) {
                var deferred = $q.defer();

                $http({
                    method: 'PATCH',
                    url: 'https://scorepredict.azure-mobile.net/tables/teams/' + teamId,
                    data: {
                        abbr: abbr,
                        name: name
                }}).success(function(data) {
                    deferred.resolve(data);
                }).error(function(data, status) {
                    deferred.reject(status);
                });

                return deferred.promise;
            }
        };
    }]).
    service('weeksSvc', ['$http', '$q', function($http, $q) {
        return {
            getWeeks: function() {
                var deferred = $q.defer();
                $http({method:'GET', url:'https://scorepredict.azure-mobile.net/tables/weeks'}).
                    success(function(data) {
                        deferred.resolve(data);
                    }).
                    error(function(data, status) {
                        deferred.reject(status);
                    });

                return deferred.promise;
            },

            saveWeek: function(week) {
                if (week.weekId != null)
                    return this.__updateWeek(week);
                return this.__insertWeek(week);
            },

            deleteWeek: function(weekId) {
                var deffered = $q.defer();
                $http({method:'DELETE', url:'https://scorepredict.azure-mobile.net/tables/weeks/' + weekId}).
                    success(function(data) {
                        deffered.resolve(data);
                    }).
                    error(function(data, status) {
                        deffered.reject(status);
                    });

                return deffered.promise;
            },

            __updateWeek: function(week) {
                var deferred = $q.defer();
                var data = JSON.stringify({
                    weekNumber: week.weekNumber,
                    year: week.year,
                    start: week.start,
                    end: week.end
                });

                $http({
                    method: 'PATCH',
                    url: 'https://scorepredict.azure-mobile.net/tables/weeks/' + week.weekId,
                    data: data
                }).success(function(data) {
                    deferred.resolve(data);
                }).error(function(data, status) {
                    deferred.reject(status);
                });

                return deferred.promise;
            },

            __insertWeek: function(week) {
                var deferred = $q.defer();
                var data = JSON.stringify({
                    weekNumber: week.weekNumber,
                    year: week.year,
                    start: week.start,
                    end: week.end
                });

                $http({
                    method: 'POST',
                    url: 'https://scorepredict.azure-mobile.net/tables/weeks',
                    data: data
                }).success(function(data) {
                    deferred.resolve(data);
                }).error(function(data, status) {
                    deferred.reject(status);
                });

                return deferred.promise;
            }
        };
    }]).
    service('gamesSvc', ['$http', '$q', function($http, $q) {
        return {
            getGames: function(weekId) {
                var deferred = $q.defer();
                $http({
                    method: 'GET',
                    url: 'https://scorepredict.azure-mobile.net/tables/games?weekId=' + weekId
                }).success(function(data) {
                    deferred.resolve(data);
                }).error(function(data, status) {
                    deferred.reject(status);
                });

                return deferred.promise;
            },

            save: function(game, id) {
                var deferred = $q.defer();
                game = {
                    gameDay: game.gameDay,
                    gameTime: game.gameTime,
                    gameState: game.gameState,
                    awayTeam: game.awayTeam,
                    awayTeamScore: game.awayTeamScore,
                    homeTeam: game.homeTeam,
                    homeTeamScore: game.homeTeamScore,
                    weekId: game.weekId
                };

                if (id == null) {
                    this.__insertGame(deferred, game);
                }
                else {
                    this.__updateGame(deferred, game, id);
                }

                return deferred.promise;
            },

            __insertGame: function(defer, game) {
                $http({
                    method: 'POST',
                    url: 'https://scorepredict.azure-mobile.net/tables/games',
                    data: game
                }).success(function(data) {
                    defer.resolve(data);
                }).error(function(data, status) {
                    defer.reject(status);
                });
            },

            __updateGame: function(defer, game, id) {
                $http({
                    method: 'PATCH',
                    url: 'https://scorepredict.azure-mobile.net/tables/games/' + id,
                    data: game
                }).success(function(data) {
                    defer.resolve(data);
                }).error(function(data, status) {
                    defer.reject(status);
                });
            }
        };
    }]);
