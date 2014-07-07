package com.farrellsoft.ScorePredict.Fragment;

import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;
import com.farrellsoft.ScorePredict.ActivityHelper;
import com.farrellsoft.ScorePredict.Adapters.HistoryYearsListAdapter;
import com.farrellsoft.ScorePredict.Handlers.IGetPredictionHistoryComplete;
import com.farrellsoft.ScorePredict.IMainActivity;
import com.farrellsoft.ScorePredict.R;
import com.farrellsoft.ScorePredict.Service.PredictionService;

import java.util.List;
import java.util.Map;

public class HistoryMainFragment extends ListFragment
{
    private IMainActivity mMainActivity;
    private PredictionService mPredictionService;

    private TextView mNoPredictions;
    private ListView mPredictionYearList;

    public HistoryMainFragment(IMainActivity mainActivity) {
        mMainActivity = mainActivity;
        mPredictionService = new PredictionService();
    }

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setHasOptionsMenu(false);

        mMainActivity.setTitle("Select a Year");
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup rootView, Bundle bundle) {
        View theView = inflater.inflate(R.layout.history_main, rootView, false);

        mNoPredictions = (TextView) theView.findViewById(R.id.noPredictionText);
        mPredictionYearList = (ListView) theView.findViewById(android.R.id.list);

        mMainActivity.showProgress();
        mPredictionService.getPredictionHistory(getActivity(), new IGetPredictionHistoryComplete() {
            @Override
            public void complete(List<Map.Entry<Integer, List<Integer>>> yearsWithPredictions) {
                if (yearsWithPredictions.size() > 0) {
                    setListAdapter(new HistoryYearsListAdapter(getActivity(), yearsWithPredictions));

                    mNoPredictions.setVisibility(View.GONE);
                    mPredictionYearList.setVisibility(View.VISIBLE);
                }
                else {
                    mNoPredictions.setVisibility(View.VISIBLE);
                    mPredictionYearList.setVisibility(View.GONE);
                }

                mMainActivity.hideProgress();
            }

            @Override
            public void fail() {
                ActivityHelper.displayErrorMessage(getActivity(), "Failed to fetch past predictions");
                mMainActivity.hideProgress();
            }
        });

        return theView;
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id) {
        // extract the selected year
        Map.Entry<Integer, List<Integer>> selection = (Map.Entry<Integer, List<Integer>>) listView.getAdapter().getItem(position);
        HistoryWeekFragment fragment = new HistoryWeekFragment(mMainActivity, selection);

        // switch the fragment
        mMainActivity.switchFragment(fragment, android.R.anim.slide_in_left, android.R.anim.slide_out_right);
    }
}
