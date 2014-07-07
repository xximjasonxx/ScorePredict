package com.farrellsoft.ScorePredict.Handlers;

import java.util.List;
import java.util.Map;

/**
 * Created by Jason Farrell on 6/13/2014.
 */
public interface IGetPredictionHistoryComplete
{
    void complete(List<Map.Entry<Integer, List<Integer>>> yearsWithPredictions);
    void fail();
}
