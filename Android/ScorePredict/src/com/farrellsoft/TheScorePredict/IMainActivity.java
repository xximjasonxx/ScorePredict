package com.farrellsoft.TheScorePredict;


import android.support.v4.app.Fragment;

/**
 * Created by Jason Farrell on 3/4/14.
 */
public interface IMainActivity
{
    void setTitle(String title);
    void showProgress();
    void hideProgress();

    void switchFragment(Fragment fragment, int enterAnimation, int exitAnimation);
}
