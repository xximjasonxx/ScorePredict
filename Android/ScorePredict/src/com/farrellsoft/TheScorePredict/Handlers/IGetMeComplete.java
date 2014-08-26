package com.farrellsoft.TheScorePredict.Handlers;

import com.farrellsoft.TheScorePredict.Entities.FacebookUser;

/**
 * Created by Jason Farrell on 6/13/2014.
 */
public interface IGetMeComplete
{
    void complete(FacebookUser currentUser);
    void fail();
}
