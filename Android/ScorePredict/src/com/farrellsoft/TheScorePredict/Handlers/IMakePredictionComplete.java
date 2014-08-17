package com.farrellsoft.TheScorePredict.Handlers;

import com.farrellsoft.TheScorePredict.Entities.Prediction;

/**
 * Created by Jason Farrell on 2/27/14.
 */
public interface IMakePredictionComplete
{
    void onComplete(boolean isSuccess, String errorMessage, Prediction prediction);
}
