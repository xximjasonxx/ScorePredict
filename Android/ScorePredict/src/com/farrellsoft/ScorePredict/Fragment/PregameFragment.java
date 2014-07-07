package com.farrellsoft.ScorePredict.Fragment;

import android.app.ProgressDialog;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.TextView;
import com.farrellsoft.ScorePredict.ActivityHelper;
import com.farrellsoft.ScorePredict.Core.GamePredictionResult;
import com.farrellsoft.ScorePredict.Handlers.IMakePredictionComplete;
import com.farrellsoft.ScorePredict.Entities.Game;
import com.farrellsoft.ScorePredict.Entities.Prediction;
import com.farrellsoft.ScorePredict.IPredictionUpdatedListener;
import com.farrellsoft.ScorePredict.R;
import com.farrellsoft.ScorePredict.Repository.RepositoryFactory;
import com.farrellsoft.ScorePredict.Repository.WeekRepository;
import com.farrellsoft.ScorePredict.Service.PredictionService;
import com.farrellsoft.ScorePredict.Views.RegisteredTextView;

public class PregameFragment extends Fragment {

    private WeekRepository weekRepository;

    private IPredictionUpdatedListener predictionListener;
    private ProgressDialog progressDialog;
    private PredictionService mPredictionService;

    public PregameFragment(IPredictionUpdatedListener listener)
    {
        predictionListener = listener;
        mPredictionService = new PredictionService();
    }

    @Override
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);

       weekRepository = RepositoryFactory.getWeekRepository();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle bundle) {
        View theView = inflater.inflate(R.layout.pregame_fragment, container, false);
        int gameId = getArguments().getInt("GameId", 0);
        GamePredictionResult result = weekRepository.getGamePredictionResult(gameId);
        Game game = result.getGame();

        if (game != null) {
            Prediction prediction = result.getPrediction();

            RegisteredTextView awayTeamName = (RegisteredTextView) theView.findViewById(R.id.awayTeamName);
            RegisteredTextView homeTeamName = (RegisteredTextView) theView.findViewById(R.id.homeTeamName);
            TextView awayTeamAbbr = (TextView) theView.findViewById(R.id.awayTeamAbbr);
            TextView homeTeamAbbr = (TextView) theView.findViewById(R.id.homeTeamAbbr);

            awayTeamName.setRegisteredText(game.getAwayTeam());
            homeTeamName.setRegisteredText(game.getHomeTeam());
            awayTeamAbbr.setText(game.getAwayTeamAbbr().toUpperCase());
            homeTeamAbbr.setText(game.getHomeTeamAbbr().toUpperCase());

            theView.findViewById(R.id.makePrediction).setOnClickListener(new MakePredictionClickListener());

            if (prediction != null) {
                EditText awayTeamPrediction = (EditText) theView.findViewById(R.id.awayTeamPrediction);
                EditText homeTeamPrediction = (EditText) theView.findViewById(R.id.homeTeamPrediction);

                awayTeamPrediction.setText(String.format("%d", prediction.getAwayTeamScore()));
                homeTeamPrediction.setText(String.format("%d", prediction.getHomeTeamScore()));
            }
        }

        return theView;
    }

    private class MakePredictionClickListener implements View.OnClickListener {
        @Override
        public void onClick(View v) {
            int awayScore = Integer.parseInt(((EditText) getView().findViewById(R.id.awayTeamPrediction)).getText().toString());
            int homeScore = Integer.parseInt(((EditText) getView().findViewById(R.id.homeTeamPrediction)).getText().toString());
            int gameId = getArguments().getInt("GameId", 0);
            GamePredictionResult result = weekRepository.getGamePredictionResult(gameId);

            Prediction prediction = result.getPrediction();
            if (prediction == null) {
                prediction = new Prediction();
                prediction.setGameId(gameId);
            }

            prediction.setAwayTeamScore(awayScore);
            prediction.setHomeTeamScore(homeScore);
            progressDialog = ProgressDialog.show(getContext(), "", "Processing...", true);

            mPredictionService.makePrediction(getContext(), prediction, new IMakePredictionComplete() {
                @Override
                public void onComplete(boolean isSuccess, String errorMessage, Prediction prediction) {
                    if (!isSuccess) {
                        ActivityHelper.displayErrorMessage(getContext(), errorMessage);
                    }
                    else {
                        predictionListener.predictionUpdated(prediction.getGameId(), 0);
                    }

                    progressDialog.hide();
                }
            });
        }
    }

    private Context getContext() {
        return getActivity();
    }
}
