package com.farrellsoft.TheScorePredict.Factory;

import android.content.Context;
import android.content.SharedPreferences;
import com.farrellsoft.TheScorePredict.Entities.User;

public class UserFactory {

    public static User getStoredUser(Context context) {
        SharedPreferences sharedPreferences = getSharedPreferences(context);

        User storedUser = null;
        if (sharedPreferences.contains("UserId") && sharedPreferences.contains("Token")) {
            storedUser = new User();
            storedUser.setToken(sharedPreferences.getString("Token", ""));
            storedUser.setUserId(sharedPreferences.getString("UserId", ""));
        }

        return storedUser;
    }

    public static SharedPreferences getSharedPreferences(Context context) {
        return context.getSharedPreferences("Authentication.prefs", 0);
    }

    public static void setStoredUser(Context context, String userId, String token) {
        SharedPreferences prefs = getSharedPreferences(context);
        SharedPreferences.Editor editor = prefs.edit();
        editor.putString("Token", token);
        editor.putString("UserId", userId);
        editor.commit();
    }

    public static void clearLogin(Context context) {
        SharedPreferences prefs = getSharedPreferences(context);
        SharedPreferences.Editor editor = prefs.edit();
        editor.clear();
        editor.commit();
    }
}
