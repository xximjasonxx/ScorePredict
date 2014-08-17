package com.farrellsoft.TheScorePredict.Fragment;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.ListFragment;
import android.view.*;
import android.widget.ListView;
import android.widget.TextView;
import com.farrellsoft.TheScorePredict.ActivityHelper;
import com.farrellsoft.TheScorePredict.Adapters.GameEntry;
import com.farrellsoft.TheScorePredict.Adapters.ScoreListAdapter;
import com.farrellsoft.TheScorePredict.Handlers.IWeekLoadComplete;
import com.farrellsoft.TheScorePredict.Entities.Week;
import com.farrellsoft.TheScorePredict.IMainActivity;
import com.farrellsoft.TheScorePredict.PredictionActivity;
import com.farrellsoft.TheScorePredict.R;
import com.farrellsoft.TheScorePredict.Service.WeekService;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CurrentWeekFragment extends ListFragment
{
    private WeekService weekService;
    private IMainActivity mainActivity;
    private String currentWeek;

    private TextView noGamesMessage;
    private ListView weekList;

    public CurrentWeekFragment(IMainActivity activity) {
        mainActivity = activity;

        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date date = new Date();
        currentWeek = dateFormat.format(date);
    }

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setHasOptionsMenu(true);

        weekService = new WeekService();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle bundle) {
        View theView = inflater.inflate(R.layout.week_view, container, false);
        noGamesMessage = (TextView) theView.findViewById(R.id.textview_nogames);
        weekList = (ListView) theView.findViewById(android.R.id.list);

        return theView;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);

        // add the icons which are specific to this fragment
        inflater.inflate(R.menu.current_week_menu, menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_refresh:
                reload();
                break;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onResume() {
        loadCurrentWeek();
        super.onResume();
    }

    private void loadCurrentWeek() {
        mainActivity.showProgress();
        weekService.loadWeek(currentWeek, getActivity(), new IWeekLoadComplete() {
            @Override
            public void onComplete(boolean isSuccess, String errorMessage, Week week) {
                if (isSuccess) {
                    showWeek(week);
                } else {
                    ActivityHelper.displayErrorMessage(getActivity(), "Failed to load current week");
                }

                mainActivity.hideProgress();
            }
        });
    }

    private void showWeek(Week week) {
        if (week.getWeekNo() > 0 && week.getYear() > 0) {
            mainActivity.setTitle(String.format("Week %d %d", week.getWeekNo(), week.getYear()));
        }

        if (week.getGames().size() > 0) {
            setListAdapter(new ScoreListAdapter(getActivity(), week.getGames(), week.getPredictions()));

            noGamesMessage.setVisibility(View.GONE);
            weekList.setVisibility(View.VISIBLE);
        }
        else {
            noGamesMessage.setVisibility(View.VISIBLE);
            weekList.setVisibility(View.GONE);
        }
    }

    @Override
    public void onListItemClick(ListView listView, View view, int position, long id) {
        GameEntry entry = (GameEntry) getListAdapter().getItem(position);
        Intent intent = new Intent(getActivity(), PredictionActivity.class);
        intent.putExtra("GameId", entry.getId());
        startActivityForResult(intent, 0);

        getActivity().overridePendingTransition(R.anim.slide_in_from_right, R.anim.slide_out_to_left);
    }

    public void reload() {
        weekService.clearWeek(currentWeek);
        loadCurrentWeek();
    }
}
