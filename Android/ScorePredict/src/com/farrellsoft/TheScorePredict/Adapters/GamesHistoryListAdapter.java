package com.farrellsoft.TheScorePredict.Adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import com.farrellsoft.TheScorePredict.Core.Convert;
import com.farrellsoft.TheScorePredict.Entities.GamePrediction;
import com.farrellsoft.TheScorePredict.GameTimeDisplayWrapper;
import com.farrellsoft.TheScorePredict.R;

import java.util.List;

public class GamesHistoryListAdapter extends ArrayAdapter<GamePrediction>
{
    public GamesHistoryListAdapter(Context context, List<GamePrediction> objects) {
        super(context, 0, objects);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.game_prediction_list_item, null);
        }

        // get the object
        GamePrediction gamePrediction = getItem(position);
        if (gamePrediction != null) {
            // get the fields
            ((TextView) convertView.findViewById(R.id.tvGameTime)).setText(new GameTimeDisplayWrapper(gamePrediction.getGameTime()).toString());
            ((ImageView) convertView.findViewById(R.id.awayTeam)).setImageDrawable(Convert.toDrawable(getContext(), gamePrediction.getAwayTeam().toLowerCase()));
            ((TextView) convertView.findViewById(R.id.awayScore)).setText(String.format("%d", gamePrediction.getAwayScore()));
            ((TextView) convertView.findViewById(R.id.awayPrediction)).setText(String.format("%d", gamePrediction.getPredictedAwayScore()));

            ((ImageView) convertView.findViewById(R.id.homeTeam)).setImageDrawable(Convert.toDrawable(getContext(), gamePrediction.getHomeTeam().toLowerCase()));
            ((TextView) convertView.findViewById(R.id.homeScore)).setText(String.format("%d", gamePrediction.getHomeScore()));
            ((TextView) convertView.findViewById(R.id.homePrediction)).setText(String.format("%d", gamePrediction.getPredictedHomeScore()));

            ((TextView) convertView.findViewById(R.id.textview_pointsawarded)).setText(String.format("%d point awarded", gamePrediction.getPointsAwarded()));
        }

        return convertView;
    }
}
