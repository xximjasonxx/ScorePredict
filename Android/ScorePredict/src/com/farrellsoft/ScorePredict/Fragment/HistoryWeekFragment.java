package com.farrellsoft.ScorePredict.Fragment;

import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import com.farrellsoft.ScorePredict.Adapters.HistoryWeeksListAdapter;
import com.farrellsoft.ScorePredict.IMainActivity;
import com.farrellsoft.ScorePredict.R;

import java.util.List;
import java.util.Map;

public class HistoryWeekFragment extends ListFragment
{
    private IMainActivity mMainActivity;
    private Integer mYear;
    private List<Integer> mWeeks;

    public HistoryWeekFragment(IMainActivity mainActivity, Map.Entry<Integer, List<Integer>> selection) {
        mMainActivity = mainActivity;
        mYear = selection.getKey();
        mWeeks = selection.getValue();
    }

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setHasOptionsMenu(false);

        mMainActivity.setTitle(String.format("Select a Week in %d", mYear));
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup rootView, Bundle bundle) {
        View theView = inflater.inflate(R.layout.history_week, rootView, false);
        setListAdapter(new HistoryWeeksListAdapter(getActivity(), mWeeks));

        return theView;
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id) {
        // extract the selected year
        Integer selection = (Integer) listView.getAdapter().getItem(position);
        HistoryGamesFragment fragment = new HistoryGamesFragment(mMainActivity, mYear, selection);

        // switch the fragment
        mMainActivity.switchFragment(fragment, android.R.anim.slide_in_left, android.R.anim.slide_out_right);
    }
}
