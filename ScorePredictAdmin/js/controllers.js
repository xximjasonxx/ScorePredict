'use strict';

/* Controllers */
angular.module('app.controllers', [])
    .controller('mainCtrl', ['$scope', 'Azureservice', function($scope, msClient) {
        $scope.isAnonymous = !msClient.isLoggedIn();
        $scope.isAuthenticated = msClient.isLoggedIn();

        if ($scope.isAuthenticated) {
            // just load the results
            loadCurrentWeek();
        }
        else {
            $scope.performLogin = function () {
                msClient.login("facebook").then(function () {
                    $scope.isAnonymous = false;
                    $scope.isAuthenticated = true;

                    loadCurrentWeek();
                }, function (error) {
                    alert("Login failed");
                });
            };
        }

        function loadCurrentWeek() {
            var lookupDate = moment().format('M/d/YYYY');
            debugger;

            /*msClient.invokeApi("weekfor", {
                method: "GET",
                body: null,
                parameters: { weekForDate: lookupDate }
            }).then(function(response) {
                loadWeekOf(response);
            }, function(error) {
                alert(error);
            });*/
        }

        function loadWeekOf(result) {
            $scope.weekNumber = result.weekNo;
            $scope.year = result.year;
            $scope.results = buildGames(result.games, result.predictions);
        }

        function buildGames(games, predictions) {
            var gamesArray = [];
            games.forEach(function(game) {
               gamesArray.push({
                  game: game,
                  prediction: findPredictionForGame(predictions, game.gameId)
               });
            });

            return gamesArray;
        }

        function findPredictionForGame(predictions, gameId) {
            var result = null;
            predictions.forEach(function(prediction) {
                if (prediction.gameId == gameId)
                    result = prediction;
            });

            return result;
        }
    }])
    .controller('teamsCtrl', ['$scope', '$modal', 'teamsSvc', function($scope, $modal, teamsSvc) {
        $scope.teams = [];

        teamsSvc.getTeams().then(function(result) {
            $scope.teams = result;
        });

        // methods
        $scope.editTeam = function(team) {
            $modal.open({
                templateUrl: 'teamView.html',
                controller: 'teamCtrl',
                resolve: {
                    team: function() {
                        return team;
                    }
                }
            });
        };
    }])
    .controller('teamCtrl', ['$scope', '$modalInstance', 'team', 'teamsSvc', function($scope, $modalInstance, $location, team, teamsSvc) {
        $scope.team = {
            abbr: team.abbr,
            name: team.name
        };

        $scope.saveTeam = function() {
            var teamId = team.id;
            var abbr = $scope.team.abbr;
            var name = $scope.team.name;

            teamsSvc.saveTeam(teamId, abbr, name).then(function(result) {
                team.abbr = result.abbr;
                team.name = result.name;

                $modalInstance.close();
            });
        };

        $scope.cancel = function() {
            $modalInstance.dismiss('cancel');
        };
    }])
    .controller('weeksCtrl', ['$scope', '$modal', '$location', 'weeksSvc', function($scope, $modal, $location, weeksSvc) {
        $scope.weeks = [];
        weeksSvc.getWeeks().then(function(data) {
           $scope.weeks = data;
        });

        $scope.addWeek = function() {
            var modal = $modal.open({
                templateUrl: 'weekModal.html',
                controller: 'weekCtrl',
                resolve: {
                    week: function() { return null; }       // this is a new week
                }
            });

            modal.result.then(function(newWeek) {
                $scope.weeks.push(newWeek);
            });
        };

        $scope.editWeek = function(week) {
            $modal.open({
                templateUrl: 'weekModal.html',
                controller: 'weekCtrl',
                resolve: {
                    week: function() {
                        return week;
                    }
                }
            });
        };

        $scope.deleteWeek = function(weekId) {
            var modal = $modal.open({
                templateUrl: 'deleteConfirmModal.html',
                controller: 'deleteWeekCtrl',
                resolve: {
                    weekId: function() {
                        return weekId;
                    }
                }
            });

            modal.result.then(function(weekId) {
                $scope.weeks = _.reject($scope.weeks, function(week) {
                    return week.id == weekId;
                });
            });
        };

        $scope.getGames = function(weekNunber, year) {
            $location.path('/games/' + weekNunber + '/' + year);
        };
    }])
    .controller('weekCtrl', ['$scope', '$modalInstance', '$filter', 'week', 'weeksSvc', function($scope, $modalInstance, $filter, week, weeksSvc) {
        $scope.week = {
            weekId: null,
            weekNumber: 1,
            year: $filter('date')(new Date(), 'yyyy'),
            start: '',
            end: ''
        };

        if (week != null) {
            $scope.week.weekId = week.id;
            $scope.week.weekNumber = week.weekNumber;
            $scope.week.year = week.year;
            $scope.week.start = week.start;
            $scope.week.end = week.end;
        }

        $scope.close = function() {
            $modalInstance.dismiss('cancel');
        };

        $scope.save = function() {
            $scope.week.start = $filter('date')(Date.parse($scope.week.start), 'MM/dd/yyyy');
            $scope.week.end = $filter('date')(Date.parse($scope.week.end), 'MM/dd/yyyy');

            weeksSvc.saveWeek($scope.week).then(function(result) {
                if (week != null) {
                    week.weekNumber = result.weekNumber;
                    week.year = result.year;
                    week.start = result.start;
                    week.end = result.end;
                }

                $modalInstance.close(result);
            });
        };
    }])
    .controller('deleteWeekCtrl', ['$scope', '$modalInstance', 'weekId', 'weeksSvc', function($scope, $modalInstance, weekId, weeksSvc) {
        $scope.close = function() {
            $modalInstance.dismiss('cancel');
        };

        $scope.confirmDelete = function() {
            weeksSvc.deleteWeek(weekId).then(function(result) {
                $modalInstance.close(weekId);
            });
        };
    }])
    .controller('gamesCtrl', ['$scope', '$routeParams', '$modal', '$location', '$q', 'weeksSvc', 'teamsSvc', 'gamesSvc',
        function($scope, $routeParams, $modal, $location, $q, weeksSvc, teamSvc, gamesSvc) {
            var weekNumber = $routeParams.weekNumber;
            var year = $routeParams.year;

            // define collections for modal selections
            var days = ['Sun', 'Mon', 'Thurs', 'Sat'];
            var states = [
                { code: 'P', display: 'Pregame' },
                { code: 'IP', display: "In Progress" },
                { code: 'F', display: "Final" }];
            var teams = [];

            $scope.games = [];

            $q.all([weeksSvc.getWeeks(), teamSvc.getTeams()]).then(function(results) {
                $scope.weeks = results[0];
                teams = results[1];

                if (weekNumber === undefined) weekNumber = $scope.weeks[0].weekNumber;
                if (year === undefined)  year = $scope.weeks[0].year;

                $scope.week = _.find($scope.weeks, function(item) {
                    return item.weekNumber == weekNumber && item.year == year;
                });

                gamesSvc.getGames($scope.week.id).then(function(result) {
                    $scope.games = result;
                });
            }
        );

        $scope.changeWeek = function() {
            $location.path('/games/' + $scope.week.weekNumber + '/' + $scope.week.year);
        };

        $scope.editGame = function(game) {
            var modal = $modal.open({
                templateUrl: 'gameModal.html',
                controller: 'gameCtrl',
                resolve: {
                    data: function() {
                        return {
                            game: {
                                gameDay: game.gameDay,
                                awayTeam: game.awayTeam,
                                awayTeamScore: game.awayTeamScore,
                                homeTeam: game.homeTeam,
                                homeTeamScore: game.homeTeamScore,
                                gameState: game.gameState,
                                time: moment(game.gameTime + "pm", "h:mma").toDate(),
                                gameId: game.gameId,
                                weekId: game.weekId
                            },
                            teams: teams,
                            days: days,
                            states: states,
                            gameId: game.id
                        };
                    }
                }
            });

            modal.result.then(function(result) {
                game.gameDay = result.gameDay;
                game.gameTime = result.gameTime;
                game.awayTeam = result.awayTeam;
                game.awayTeamScore = result.awayTeamScore;
                game.homeTeam = result.homeTeam;
                game.homeTeamScore = result.homeTeamScore;
                game.gameState = result.gameState;
            });
        };

        $scope.addGame = function() {
            var modal = $modal.open({
                templateUrl: 'gameModal.html',
                controller: 'gameCtrl',
                resolve: {
                    data: function() {
                        return {
                            game: {
                                gameDay: days[0],
                                awayTeam: teams[0].abbr,
                                awayTeamScore: 0,
                                homeTeam: teams[1].abbr,
                                homeTeamScore: 0,
                                gameState: states[0].code,
                                time: moment("1:00pm", "h:mma").toDate(),
                                gameId: "-1",           // this value tells the service to generate a new Id
                                weekId: $scope.week.id
                            },
                            teams: teams,
                            states: states,
                            days: days,
                            gameId: null
                        }
                    }
                }
            });

            modal.result.then(function(newGame) {
                $scope.games.push(newGame);
            });
        };
    }])
    .controller('gameCtrl', ['$scope', 'data', '$modalInstance', 'gamesSvc', function($scope, data, $modalInstance, gamesSvc) {
        $scope.teams = data.teams.map(function(t) {
            return t.abbr;
        });
        $scope.states = data.states;
        $scope.days = data.days;

        $scope.game = data.game;
        $scope.close = function() {
            $modalInstance.dismiss('cancel');
        };

        $scope.save = function() {
            var game = $scope.game;
            game.gameTime = moment(game.time).format("h:mm");

            gamesSvc.save(game, data.gameId).then(function(result) {        // mobile service uses a different game id than as stored
                $modalInstance.close(result);
            });
        };
    }])
    .controller('predictionsCtrl', [function() {

    }])
    .controller('navigationCtrl', ['$scope', '$location', function($scope, $location) {
        $scope.isActive = function(viewLocation) {
            var regex = new RegExp("^" + viewLocation);
            return regex.exec($location.path());
        };
    }]);