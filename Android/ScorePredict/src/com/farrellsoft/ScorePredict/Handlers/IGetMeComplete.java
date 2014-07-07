package com.farrellsoft.ScorePredict.Handlers;

import com.farrellsoft.ScorePredict.Entities.FacebookUser;

/**
 * Created by Jason Farrell on 6/13/2014.
 */
public interface IGetMeComplete
{
    void complete(FacebookUser currentUser);
    void fail();
}
