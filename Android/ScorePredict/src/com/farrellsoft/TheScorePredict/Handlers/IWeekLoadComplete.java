package com.farrellsoft.TheScorePredict.Handlers;

import com.farrellsoft.TheScorePredict.Entities.Week;

/**
 * Created by Jason Farrell on 2/26/14.
 */
public interface IWeekLoadComplete {
    void onComplete(boolean isSuccess, String errorMessage, Week week);
}
