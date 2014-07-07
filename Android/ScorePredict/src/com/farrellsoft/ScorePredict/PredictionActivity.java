package com.farrellsoft.ScorePredict;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;
import com.farrellsoft.ScorePredict.Core.Convert;
import com.farrellsoft.ScorePredict.Core.GamePredictionResult;
import com.farrellsoft.ScorePredict.Entities.Game;
import com.farrellsoft.ScorePredict.Fragment.ConcludedGameFragment;
import com.farrellsoft.ScorePredict.Fragment.PregameFragment;
import com.farrellsoft.ScorePredict.Repository.RepositoryFactory;
import com.farrellsoft.ScorePredict.Repository.WeekRepository;

public class PredictionActivity extends FragmentActivity implements IPredictionUpdatedListener {

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.prediction);

        int gameId = getIntent().getIntExtra("GameId", 0);
        if (gameId > 0) {
            WeekRepository repo = RepositoryFactory.getWeekRepository();
            GamePredictionResult result = repo.getGamePredictionResult(gameId);
            if (result.getGame() != null) {
                buildUI(result.getGame());

                FragmentManager fragmentManager = getSupportFragmentManager();
                FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                Fragment fragment = null;

                if (result.getGame().inPregame()) {
                    fragment = new PregameFragment(this);
                }

                if (result.getGame().hasConcluded()) {
                    fragment = new ConcludedGameFragment();
                }

                fragment.setArguments(getIntent().getExtras());
                fragmentTransaction.add(R.id.fragmentFrame, fragment);
                fragmentTransaction.commit();
            }
        }

        findViewById(R.id.predictionHeader).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setResult(RESULT_CANCELED);
                exitActivity();
            }
        });
    }

    private void buildUI(Game game) {
        // get the views we will be updating
        ImageView awayTeam = (ImageView) findViewById(R.id.awayTeam);
        ImageView homeTeam = (ImageView) findViewById(R.id.homeTeam);
        TextView gameTime = (TextView) findViewById(R.id.gameTime);

        // set the values from the game
        awayTeam.setImageDrawable(Convert.toDrawable(this, game.getAwayTeamAbbr()));
        homeTeam.setImageDrawable(Convert.toDrawable(this, game.getHomeTeamAbbr()));

        GameTimeDisplayWrapper wrapper = new GameTimeDisplayWrapper(game.getTime());
        gameTime.setText(String.format("%s @ %s", game.getDay(), wrapper.toString()));
    }

    @Override
    public void onBackPressed() {
        setResult(RESULT_CANCELED);
        exitActivity();
    }

    @Override
    public void predictionUpdated(int gameId, int predictionId) {
        setResult(RESULT_OK);
        exitActivity();
    }

    private void exitActivity() {
        finish();
        overridePendingTransition(R.anim.slide_in_from_left, R.anim.slide_out_to_right);
    }
}