package com.farrellsoft.TheScorePredict.Repository;

import android.content.OperationApplicationException;
import com.farrellsoft.TheScorePredict.Core.GamePredictionResult;
import com.farrellsoft.TheScorePredict.Entities.Game;
import com.farrellsoft.TheScorePredict.Entities.Prediction;
import com.farrellsoft.TheScorePredict.Entities.Week;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WeekRepository
{
    private Map<String, Week> _weekCache;
    public WeekRepository() {
        _weekCache = new HashMap<String, Week>();
    }

    public void addWeek(String dateString, Week week) {
        _weekCache.put(dateString, week);
    }

    public Week getWeek(String dateString) {
        if (!_weekCache.containsKey(dateString))
            return null;

        return _weekCache.get(dateString);
    }

    public GamePredictionResult getGamePredictionResult(int gameId) {
        GamePredictionResult result = new GamePredictionResult();
        for (Map.Entry<String, Week> entry : _weekCache.entrySet()) {

            result.setGame(findGame(entry.getValue().getGames(), gameId));
            if (result.getGame() != null) {
                result.setPrediction(findPrediction(entry.getValue().getPredictions(), gameId));
            }
        }

        return result;
    }

    private Game findGame(List<Game> games, int gameId) {
        for (Game game : games) {
            if (game.getId() == gameId)
                return game;
        }

        return null;
    }

    private Prediction findPrediction(List<Prediction> predictions, int gameId) {
        for (Prediction prediction : predictions) {
            if (prediction.getGameId() == gameId)
                return prediction;
        }

        return null;
    }

    public void addPrediction(Prediction prediction) throws OperationApplicationException {
        Week week = findWeekForGame(prediction.getGameId());
        for (Prediction p : week.getPredictions()) {
            if (p.getGameId() == prediction.getGameId())
                throw new OperationApplicationException("A prediction already exists for this game");
        }

        week.getPredictions().add(prediction);
    }

    public void updatePrediction(Prediction prediction) throws OperationApplicationException {
        Week week = findWeekForGame(prediction.getGameId());
        int predictionIndex = week.getPredictions().indexOf(prediction);
        if (predictionIndex < 0)
            throw new OperationApplicationException("The prediction to update does not exist for this game");

        Prediction thePrediction = week.getPredictions().get(predictionIndex);
        thePrediction.setHomeTeamScore(prediction.getHomeTeamScore());
        thePrediction.setAwayTeamScore(prediction.getAwayTeamScore());
    }

    private Week findWeekForGame(int gameId) throws OperationApplicationException {
        for (Map.Entry<String, Week> entry : _weekCache.entrySet()) {
            for (Game game : entry.getValue().getGames()) {
                if (game.getId() == gameId)
                    return entry.getValue();
            }
        }

        throw new OperationApplicationException("Could not find a week containing the desired game");
    }

    public void clearWeek(String weekString) {
        if (_weekCache.containsKey(weekString)) {
            _weekCache.remove(weekString);
        }
    }
}
