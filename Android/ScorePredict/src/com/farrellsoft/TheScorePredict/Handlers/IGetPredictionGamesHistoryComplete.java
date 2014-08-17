package com.farrellsoft.TheScorePredict.Handlers;

import com.farrellsoft.TheScorePredict.Entities.GamePrediction;

import java.util.List;

/**
 * Created by Jason Farrell on 6/19/2014.
 */
public interface IGetPredictionGamesHistoryComplete
{
    void complete(List<GamePrediction> predictions);
    void fail();
}
