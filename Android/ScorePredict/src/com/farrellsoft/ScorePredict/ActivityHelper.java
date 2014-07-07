package com.farrellsoft.ScorePredict;

import android.app.AlertDialog;
import android.content.Context;

public class ActivityHelper {

    public static void displayErrorMessage(Context context, String errorMessage) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setCancelable(true)
                .setMessage(errorMessage)
                .setTitle("An error occurred")
                .setPositiveButton("Ok", null);

        builder.create().show();
    }

    public static void displayNoConnectionErrorMessage(Context context) {
        String message = context.getResources().getString(R.string.NoConnectionErrorMessage);
        displayErrorMessage(context, message);
    }

    public static void displayFailedToLoadCurrentWeeGamesErrorMessage(Context context) {
        String message = context.getResources().getString(R.string.CurrentWeekGamesLoadFailed);
        displayErrorMessage(context, message);
    }
}
