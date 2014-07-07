package com.farrellsoft.ScorePredict.Handlers;

import com.farrellsoft.ScorePredict.Entities.Prediction;

/**
 * Created by Jason Farrell on 2/27/14.
 */
public interface IMakePredictionComplete
{
    void onComplete(boolean isSuccess, String errorMessage, Prediction prediction);
}
