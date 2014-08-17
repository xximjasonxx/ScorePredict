package com.farrellsoft.TheScorePredict.Fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.farrellsoft.TheScorePredict.R;

/**
 * Created by Jason Farrell on 3/4/14.
 */
public class AboutFragment extends Fragment
{
    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setHasOptionsMenu(false);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle bundle) {
        return inflater.inflate(R.layout.about, container, false);
    }
}
