'use strict';

/* Filters */

angular.module('app.filters', []).
  filter('interpolate', ['version', function(version) {
    return function(text) {
      return String(text).replace(/\%VERSION\%/mg, version);
    }
  }]).
  filter('printState', [function() {
    return function(text) {
      switch (text) {
          case 'P': return 'Pregame';
          case 'F': return 'Final';
          default: return 'In Progress';
      }
    }
  }]).
  filter('predictionString', [function() {
    return function(resultObject) {
        var game = resultObject.game;
        var prediction = resultObject.prediction;

        if (prediction == null)
            return "No Prediction";

        if (prediction.predictedAwayScore > prediction.predictedHomeScore)
            return game.awayAbbr + " to win " + prediction.predictedAwayScore + "-" + prediction.predictedHomeScore;

        if (prediction.predictedHomeScore > prediction.predictedAwayScore)
            return game.homeAbbr + " to win " + prediction.predictedHomeScore + "-" + prediction.predictedAwayScore;

        if (prediction.homeTeamScore == prediction.awayTeamScore)
            return game.homeAbbr + " and " + game.awayAbbr + " to tie " + prediction.predictedHomeScore + "-" + prediction.predictedAwayScore;
    }
  }]);