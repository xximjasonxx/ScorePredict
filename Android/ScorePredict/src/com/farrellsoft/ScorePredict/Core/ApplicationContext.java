package com.farrellsoft.ScorePredict.Core;

import com.farrellsoft.ScorePredict.Entities.FacebookUser;

/**
 * Created by Jason Farrell on 6/12/2014.
 */
public class ApplicationContext
{
    private static ApplicationContext _currentInstance;

    public static ApplicationContext get_currentInstance() {
        if (_currentInstance == null)
            _currentInstance = new ApplicationContext();

        return _currentInstance;
    }

    // instance members
    private FacebookUser mCurrentUser;

    private ApplicationContext() { }


    public FacebookUser getCurrentUser() {
        return mCurrentUser;
    }

    public void setCurrentUser(FacebookUser mCurrentUser) {
        this.mCurrentUser = mCurrentUser;
    }
}
