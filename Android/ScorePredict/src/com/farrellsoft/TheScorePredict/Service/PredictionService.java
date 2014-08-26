package com.farrellsoft.TheScorePredict.Service;

import android.content.Context;
import android.content.OperationApplicationException;
import android.util.Pair;
import com.farrellsoft.TheScorePredict.Core.Convert;
import com.farrellsoft.TheScorePredict.Entities.GamePrediction;
import com.farrellsoft.TheScorePredict.Handlers.IGetPredictionGamesHistoryComplete;
import com.farrellsoft.TheScorePredict.Handlers.IGetPredictionHistoryComplete;
import com.farrellsoft.TheScorePredict.Handlers.IMakePredictionComplete;
import com.farrellsoft.TheScorePredict.Entities.Prediction;
import com.farrellsoft.TheScorePredict.Factory.ClientFactory;
import com.farrellsoft.TheScorePredict.Repository.RepositoryFactory;
import com.farrellsoft.TheScorePredict.Repository.WeekRepository;
import com.google.gson.JsonElement;
import com.microsoft.windowsazure.mobileservices.*;

import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.List;

public class PredictionService
{
    public void makePrediction(Context context, Prediction prediction, IMakePredictionComplete completeHandler) {
        try {
            MobileServiceClient client = ClientFactory.getAuthenticatedClient(context);
            MobileServiceTable<Prediction> table = client.getTable("predictions", Prediction.class);
            if (prediction.getId() > 0) {
                updatePrediction(table, prediction, completeHandler);
            }
            else {
                insertPrediction(table, prediction, completeHandler);
            }
        } catch (MalformedURLException e) {
            completeHandler.onComplete(false, "Could not connected to Prediction service", null);
        }
    }

    public void getPredictionHistory(Context context, final IGetPredictionHistoryComplete completeHandler) {
        try {
            MobileServiceClient client = ClientFactory.getAuthenticatedClient(context);
            client.invokeApi("prediction_history", "GET", null, new ApiJsonOperationCallback() {
                @Override
                public void onCompleted(JsonElement jsonElement, Exception e, ServiceFilterResponse serviceFilterResponse) {
                    if (e == null) {
                        completeHandler.complete(Convert.toEntrySet(jsonElement));
                    }
                    else {
                        completeHandler.fail();
                    }
                }
            });
        }
        catch (MalformedURLException e) {
            completeHandler.fail();
        }
    }

    public void getPredictionGamesHistory(Context context, int year, int weekNumber, final IGetPredictionGamesHistoryComplete handler) {
        try {
            MobileServiceClient client = ClientFactory.getAuthenticatedClient(context);
            List<Pair<String, String>> parameters = new ArrayList<Pair<String, String>>();
            parameters.add(new Pair<String, String>("year", new Integer(year).toString()));
            parameters.add(new Pair<String, String>("weekNumber", new Integer(weekNumber).toString()));

            client.invokeApi("prediction_games_history", "GET", parameters, new ApiJsonOperationCallback() {
                @Override
                public void onCompleted(JsonElement jsonElement, Exception e, ServiceFilterResponse serviceFilterResponse) {
                    if (e == null) {
                        List<GamePrediction> games = Convert.toGamePredictionArray(jsonElement.getAsJsonObject().get("predictions").getAsJsonArray());

                        handler.complete(games);
                    }
                    else {
                        handler.fail();
                    }
                }
            });
        }
        catch (MalformedURLException ex) {
            handler.fail();
        }
    }

    private static void updatePrediction(MobileServiceTable<Prediction> table, Prediction prediction, final IMakePredictionComplete listener) {
        table.update(prediction, new TableOperationCallback<Prediction>() {
            @Override
            public void onCompleted(Prediction prediction, Exception e, ServiceFilterResponse serviceFilterResponse) {
                if (e == null) {
                    try {
                        updatePrediction(prediction);
                        listener.onComplete(true, "", prediction);
                    } catch (OperationApplicationException e1) {
                        listener.onComplete(false, e1.getMessage(), null);
                    }
                }

                if (e != null)
                    listener.onComplete(true, e.getMessage(), null);
            }
        });
    }

    private static void insertPrediction(MobileServiceTable<Prediction> table, Prediction prediction, final IMakePredictionComplete listener) {
        table.insert(prediction, new TableOperationCallback<Prediction>() {
            @Override
            public void onCompleted(Prediction prediction, Exception e, ServiceFilterResponse serviceFilterResponse) {
                if (e == null) {
                    try {
                        addPrediction(prediction);
                        listener.onComplete(true, "", prediction);
                    } catch (OperationApplicationException e1) {
                        listener.onComplete(false, e1.getMessage(), null);
                    }
                }

                if (e != null)
                    listener.onComplete(false, e.getMessage(), null);
            }
        });
    }

    private static void updatePrediction(Prediction prediction) throws OperationApplicationException {
        WeekRepository repo = RepositoryFactory.getWeekRepository();
        repo.updatePrediction(prediction);
    }

    private static void addPrediction(Prediction prediction) throws OperationApplicationException {
        WeekRepository repo = RepositoryFactory.getWeekRepository();
        repo.addPrediction(prediction);
    }
}
