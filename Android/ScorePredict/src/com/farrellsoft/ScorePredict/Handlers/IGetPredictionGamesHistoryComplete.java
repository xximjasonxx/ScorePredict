package com.farrellsoft.ScorePredict.Handlers;

import com.farrellsoft.ScorePredict.Entities.Game;
import com.farrellsoft.ScorePredict.Entities.GamePrediction;
import com.farrellsoft.ScorePredict.Entities.Prediction;

import java.util.List;

/**
 * Created by Jason Farrell on 6/19/2014.
 */
public interface IGetPredictionGamesHistoryComplete
{
    void complete(List<GamePrediction> predictions);
    void fail();
}
