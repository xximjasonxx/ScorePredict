package com.farrellsoft.ScorePredict.Fragment;

import android.support.v4.app.Fragment;
import com.farrellsoft.ScorePredict.IMainActivity;

/**
 * Created by Jason Farrell on 3/4/14.
 */
public final class FragmentFactory
{
    private static final int CURRENT_WEEK_POSITION = 0;
    private static final int HISTORY_POSITION = 1;
    private static final int LEADERBOARDS_POSITION = 2;
    private static final int SETTINGS_POSITION = 3;

    public static Fragment getFragment(int position, IMainActivity mainActivity) {
        switch (position) {
            case CURRENT_WEEK_POSITION:
                return new CurrentWeekFragment(mainActivity);

            case HISTORY_POSITION:
                return new HistoryMainFragment(mainActivity);

            default:
                return new AboutFragment();
        }
    }
}
