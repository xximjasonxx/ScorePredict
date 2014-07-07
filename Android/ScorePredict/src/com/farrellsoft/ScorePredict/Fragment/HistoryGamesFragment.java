package com.farrellsoft.ScorePredict.Fragment;

import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.farrellsoft.ScorePredict.ActivityHelper;
import com.farrellsoft.ScorePredict.Adapters.GamesHistoryListAdapter;
import com.farrellsoft.ScorePredict.Entities.Game;
import com.farrellsoft.ScorePredict.Entities.GamePrediction;
import com.farrellsoft.ScorePredict.Entities.Prediction;
import com.farrellsoft.ScorePredict.Handlers.IGetPredictionGamesHistoryComplete;
import com.farrellsoft.ScorePredict.IMainActivity;
import com.farrellsoft.ScorePredict.R;
import com.farrellsoft.ScorePredict.Service.PredictionService;

import java.util.List;

public class HistoryGamesFragment extends ListFragment
{
    private IMainActivity mMainActivity;
    private Integer mYear;
    private Integer mWeekNumber;
    private PredictionService mPredictionService;

    public HistoryGamesFragment(IMainActivity mainActivity, int year, int weekNo) {
        mMainActivity = mainActivity;
        mYear = year;
        mWeekNumber = weekNo;

        mPredictionService = new PredictionService();
    }

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setHasOptionsMenu(false);

        mMainActivity.setTitle(String.format("Predictions for Week %d %d", mWeekNumber, mYear));
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup rootView, Bundle bundle) {
        View theView = inflater.inflate(R.layout.history_games, rootView, false);
        mMainActivity.showProgress();
        mPredictionService.getPredictionGamesHistory(getActivity(), mYear, mWeekNumber, new IGetPredictionGamesHistoryComplete() {
            @Override
            public void complete(List<GamePrediction> games) {
                setListAdapter(new GamesHistoryListAdapter(getActivity(), games));
                mMainActivity.hideProgress();
            }

            @Override
            public void fail() {
                mMainActivity.hideProgress();
                ActivityHelper.displayErrorMessage(getActivity(), "Failed to get Games for the Week and Year");
            }
        });

        return theView;
    }
}
