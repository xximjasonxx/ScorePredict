package com.farrellsoft.TheScorePredict.Adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import com.farrellsoft.TheScorePredict.Core.Convert;
import com.farrellsoft.TheScorePredict.Entities.Game;
import com.farrellsoft.TheScorePredict.Entities.Prediction;
import com.farrellsoft.TheScorePredict.GameStateDisplayWrapper;
import com.farrellsoft.TheScorePredict.GameTimeDisplayWrapper;
import com.farrellsoft.TheScorePredict.R;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class ScoreListAdapter extends ArrayAdapter<IEntry> {

    private final int SECTION_ITEM_VIEW_TYPE = 0;
    private final int GAME_ITEM_VIEW_TYPE = 1;
    private List<Prediction> _predictions;

    public ScoreListAdapter(Context context, List<Game> games, List<Prediction> predictions) {
        super(context, 0, new ArrayList<IEntry>());

        // determine the sections
        addAll(buildEntryList(games));
        _predictions = predictions;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        IEntry currentEntry = getItem(position);
        if (currentEntry.isSection() && currentEntry instanceof GameSectionEntry) {
            return getViewForSection((GameSectionEntry) currentEntry, convertView);
        }

        if (!currentEntry.isSection() && currentEntry instanceof GameEntry) {
            return getViewForGame((GameEntry) currentEntry, convertView);
        }

        return convertView;
    }

    @Override
    public int getViewTypeCount() {
        return 2;
    }

    @Override
    public int getItemViewType(int position) {
        IEntry entry = getItem(position);
        if (entry instanceof GameSectionEntry)
            return SECTION_ITEM_VIEW_TYPE;

        return GAME_ITEM_VIEW_TYPE;
    }

    @Override
    public boolean isEnabled(int position) {
        IEntry entry = getItem(position);
        if (entry instanceof GameSectionEntry)
            return false;

        GameEntry gameEntry = (GameEntry) entry;
        boolean result = gameEntry.inPregame() || gameEntry.isConcluded();
        return result;
    }

    private View getViewForGame(GameEntry gameEntry, View theView) {
        ViewHolder viewHolder;

        if (theView == null) {
            theView = LayoutInflater.from(getContext()).inflate(R.layout.game_list_item, null);
            viewHolder = new ViewHolder();

            viewHolder.awayTeam = (ImageView) theView.findViewById(R.id.awayTeam);
            viewHolder.homeTeam = (ImageView) theView.findViewById(R.id.homeTeam);
            viewHolder.awayScore = (TextView) theView.findViewById(R.id.awayScore);
            viewHolder.homeScore = (TextView) theView.findViewById(R.id.homeScore);
            viewHolder.gameTime = (TextView) theView.findViewById(R.id.tvGameTime);
            viewHolder.gameState = (TextView) theView.findViewById(R.id.tvGameState);
            viewHolder.awayPrediction = (TextView) theView.findViewById(R.id.awayPrediction);
            viewHolder.homePrediction = (TextView) theView.findViewById(R.id.homePrediction);

            theView.setTag(viewHolder);
        }
        else {
            viewHolder = (ViewHolder) theView.getTag();
        }

        viewHolder.awayTeam.setImageDrawable(Convert.toDrawable(getContext(), gameEntry.getAwayAbbr()));
        viewHolder.homeTeam.setImageDrawable(Convert.toDrawable(getContext(), gameEntry.getHomeAbbr()));
        viewHolder.awayScore.setText(String.format("%d", gameEntry.getAwayScore()));
        viewHolder.homeScore.setText(String.format("%d", gameEntry.getHomeScore()));
        viewHolder.gameTime.setText(new GameTimeDisplayWrapper(gameEntry.getTime()).toString());
        viewHolder.gameState.setText(new GameStateDisplayWrapper(gameEntry.getState()).toString());

        Prediction prediction = getPrediction(gameEntry.getId());
        viewHolder.awayPrediction.setVisibility(View.GONE);
        viewHolder.homePrediction.setVisibility(View.GONE);

        if (prediction != null)
        {
            viewHolder.awayPrediction.setVisibility(View.VISIBLE);
            viewHolder.homePrediction.setVisibility(View.VISIBLE);
            viewHolder.awayPrediction.setText(String.format("%d", prediction.getAwayTeamScore()));
            viewHolder.homePrediction.setText(String.format("%d", prediction.getHomeTeamScore()));
        }

        return theView;
    }

    private Prediction getPrediction(int gameId) {
        if (_predictions.size() >= 0) {
        for (Prediction prediction : _predictions)
            if (prediction.getGameId() == gameId)
                return prediction;
        }

        return null;
    }

    private View getViewForSection(GameSectionEntry sectionEntry, View theView) {
        if (theView == null) {
            theView = LayoutInflater.from(getContext()).inflate(R.layout.game_list_title, null);
        }

        TextView tvSectionTitle = (TextView) theView.findViewById(R.id.tvSectionTitle);
        tvSectionTitle.setText(sectionEntry.getSectionName());

        return theView;
    }

    private List<IEntry> buildEntryList(List<Game> gameList) {
        List<IEntry> returnList = new ArrayList<IEntry>();
        String previousSectionName = "";
        Collections.sort(gameList, new GameComparator());

        for (Game game : gameList) {
            if (!game.getDay().equalsIgnoreCase(previousSectionName)) {
                returnList.add(new GameSectionEntry(game.getDay()));
                previousSectionName = game.getDay();
            }

            returnList.add(new GameEntry(game));
        }

        return returnList;
    }

    private class GameComparator implements Comparator<Game> {

        @Override
        public int compare(Game lhs, Game rhs) {
            if (lhs.getDay().equalsIgnoreCase(rhs.getDay())) {
                if (lhs.getTime().contentEquals(rhs.getTime())) {
                    return 0;       // both are equal
                }

                return compareTime(lhs.getTime(), rhs.getTime());
            }

            return compareDay(lhs.getDay(), rhs.getDay());
        }

        private int compareDay(String leftHandDay, String rightHandDay) {
            int lhsDayValue = getDayValue(leftHandDay);
            int rhsDayValue = getDayValue(rightHandDay);

            if (lhsDayValue < rhsDayValue)
                return -1;

            return 1;
        }

        private int compareTime(String leftHandTime, String rightHandTime) {
            // remove the expected colon in the time string
            String parsedLeftTime = leftHandTime.replace(":", "");
            String parsedRightTime = rightHandTime.replace(":", "");

            int left = Integer.parseInt(parsedLeftTime);
            int right = Integer.parseInt(parsedRightTime);
            if (left < right)
                return -1;

            return 1;
        }

        private int getDayValue(String dayName) {
            if (dayName.equalsIgnoreCase("Thu")) {
                return 0;
            }

            if (dayName.equalsIgnoreCase("Sun")) {
                return 1;
            }

            return 2;
        }
    }

    private static class ViewHolder {
        ImageView awayTeam;
        ImageView homeTeam;
        TextView awayScore;
        TextView homeScore;
        TextView gameTime;
        TextView gameState;
        TextView awayPrediction;
        TextView homePrediction;
    }
}
