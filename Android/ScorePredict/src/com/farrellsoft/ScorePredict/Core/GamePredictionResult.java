package com.farrellsoft.ScorePredict.Core;

import com.farrellsoft.ScorePredict.Entities.Game;
import com.farrellsoft.ScorePredict.Entities.Prediction;

/**
 * Created by Jason Farrell on 2/26/14.
 */
public class GamePredictionResult
{
    private Game _game;
    private Prediction _prediction;

    public Game getGame() {
        return _game;
    }

    public void setGame(Game game) {
        _game = game;
    }

    public Prediction getPrediction() {
        return _prediction;
    }

    public void setPrediction(Prediction prediction) {
        _prediction = prediction;
    }
}
