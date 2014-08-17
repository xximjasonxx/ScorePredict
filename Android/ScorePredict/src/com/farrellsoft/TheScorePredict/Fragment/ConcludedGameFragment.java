package com.farrellsoft.TheScorePredict.Fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import com.farrellsoft.TheScorePredict.Core.GamePredictionResult;
import com.farrellsoft.TheScorePredict.Entities.Game;
import com.farrellsoft.TheScorePredict.Entities.Prediction;
import com.farrellsoft.TheScorePredict.R;
import com.farrellsoft.TheScorePredict.Repository.RepositoryFactory;
import com.farrellsoft.TheScorePredict.Repository.WeekRepository;
import com.farrellsoft.TheScorePredict.Views.RegisteredTextView;

public class ConcludedGameFragment extends Fragment {

    private WeekRepository weekRepository;

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);

        weekRepository = RepositoryFactory.getWeekRepository();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle bundle) {
        int gameId = getArguments().getInt("GameId", 0);
        View theView = inflater.inflate(R.layout.concluded_fragment, container, false);

        if (gameId > 0) {
            GamePredictionResult result = weekRepository.getGamePredictionResult(gameId);
            Game game = result.getGame();
            Prediction prediction = result.getPrediction();

            RegisteredTextView awayTeamName = (RegisteredTextView) theView.findViewById(R.id.awayTeamName);
            RegisteredTextView homeTeamName = (RegisteredTextView) theView.findViewById(R.id.homeTeamName);
            TextView awayTeamAbbr = (TextView) theView.findViewById(R.id.awayTeamAbbr);
            TextView homeTeamAbbr = (TextView) theView.findViewById(R.id.homeTeamAbbr);
            TextView awayFinalScore = (TextView) theView.findViewById(R.id.awayFinalScore);
            TextView homeFinalScore = (TextView) theView.findViewById(R.id.homeFinalScore);

            awayTeamName.setRegisteredText(game.getAwayTeam());
            homeTeamName.setRegisteredText(game.getHomeTeam());
            awayTeamAbbr.setText(game.getAwayTeamAbbr().toUpperCase());
            homeTeamAbbr.setText(game.getHomeTeamAbbr().toUpperCase());
            awayFinalScore.setText(String.format("%d", game.getAwayScore()));
            homeFinalScore.setText(String.format("%d", game.getHomeScore()));

            if (prediction != null) {
                loadForPrediction(theView, prediction);
            }
            else {
                theView.findViewById(R.id.AwayPrediction).setVisibility(View.GONE);
                theView.findViewById(R.id.HomePrediction).setVisibility(View.GONE);
            }
        }

        return theView;
    }

    private void loadForPrediction(View theView, Prediction prediction) {
        TextView awayTeamPrediction = (TextView) theView.findViewById(R.id.awayTeamPrediction);
        TextView homeTeamPrediction = (TextView) theView.findViewById(R.id.homeTeamPrediction);
        TextView predictionPoints = (TextView) theView.findViewById(R.id.predictionPoints);

        theView.findViewById(R.id.noPredictionText).setVisibility(View.GONE);
        awayTeamPrediction.setText(String.format("%d", prediction.getAwayTeamScore()));
        homeTeamPrediction.setText(String.format("%d", prediction.getHomeTeamScore()));

        if (prediction.getPointsAwarded() == 1) {
            predictionPoints.setText("1pt");
        }
        else {
            predictionPoints.setText(String.format("%dpts", prediction.getPointsAwarded()));
        }
    }
}
