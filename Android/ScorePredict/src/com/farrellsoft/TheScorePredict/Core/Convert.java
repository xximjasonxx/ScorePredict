package com.farrellsoft.TheScorePredict.Core;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.drawable.Drawable;

import com.farrellsoft.TheScorePredict.Entities.FacebookUser;
import com.farrellsoft.TheScorePredict.Entities.Game;
import com.farrellsoft.TheScorePredict.Entities.GamePrediction;
import com.farrellsoft.TheScorePredict.Entities.Prediction;
import com.farrellsoft.TheScorePredict.Entities.Week;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.*;

public final class Convert {

    public static Week toWeek(JsonObject jsonObject) {
        Week returnWeek = new Week();
        returnWeek.setWeekNo(jsonObject.get("weekNo").getAsInt());
        returnWeek.setYear(jsonObject.get("year").getAsInt());
        returnWeek.setGames(Convert.toGameArray(jsonObject.getAsJsonArray("games")));
        returnWeek.setPredictions(Convert.toPredictionsArray(jsonObject.getAsJsonArray("predictions")));

        return returnWeek;
    }

    public static List<Game> toGameArray(JsonArray arrayRoot) {
        List<Game> gameList = new ArrayList<Game>();
        for (JsonElement element : arrayRoot)
            gameList.add(Convert.toGame(element.getAsJsonObject()));

        return gameList;
    }

    public static List<FacebookUser> toFriendArray(JsonArray arrayRoot) {
        List<FacebookUser> facebookUsers = new ArrayList<FacebookUser>();
        for (JsonElement element : arrayRoot) {
            facebookUsers.add(Convert.toFacebookUser(element.getAsJsonObject()));
        }

        return facebookUsers;
    }

    public static Game toGame(JsonObject jsonObject) {
        Game game = new Game();
        game.setId(jsonObject.get("gameId").getAsInt());
        game.setAwayScore(jsonObject.get("awayScore").getAsInt());

        if (jsonObject.has("awayTeam"))
            game.setAwayTeam(jsonObject.get("awayTeam").getAsString());
        game.setDay(jsonObject.get("gameDay").getAsString());
        game.setHomeScore(jsonObject.get("homeScore").getAsInt());

        if (jsonObject.has("homeTeam"))
            game.setHomeTeam(jsonObject.get("homeTeam").getAsString());
        game.setState(jsonObject.get("gameState").getAsCharacter());

        if (jsonObject.has("weekNo"))
            game.setWeekNo(jsonObject.get("weekNo").getAsInt());

        if (jsonObject.has("year"))
            game.setYear(jsonObject.get("year").getAsInt());
        game.setTime(jsonObject.get("gameTime").getAsString());
        game.setAwayTeamAbbr(jsonObject.get("awayAbbr").getAsString().toLowerCase());
        game.setHomeTeamAbbr(jsonObject.get("homeAbbr").getAsString().toLowerCase());

        return game;
    }

    public static FacebookUser toFacebookUser(JsonObject jsonObject) {
        FacebookUser facebookUser = new FacebookUser();
        facebookUser.setId(jsonObject.get("uid").getAsString());
        facebookUser.setName(jsonObject.get("name").getAsString());
        facebookUser.setImageUrl(jsonObject.get("pic").getAsString());

        return facebookUser;
    }

    public static List<Prediction> toPredictionsArray(JsonArray arrayRoot) {
        List<Prediction> predictionList = new ArrayList<Prediction>();
        for (JsonElement element : arrayRoot) {
            predictionList.add(Convert.toPrediction(element.getAsJsonObject()));
        }

        return predictionList;
    }

    public static Prediction toPrediction(JsonObject jsonObject) {
        Prediction returnPrediction = new Prediction();
        returnPrediction.setId(jsonObject.get("id").getAsInt());
        returnPrediction.setGameId(jsonObject.get("gameId").getAsInt());
        returnPrediction.setAwayTeamScore(jsonObject.get("predictedAwayScore").getAsInt());
        returnPrediction.setHomeTeamScore(jsonObject.get("predictedHomeScore").getAsInt());
        returnPrediction.setPointsAwarded(jsonObject.get("pointsAwarded").getAsInt());

        return returnPrediction;
    }

    public static List<GamePrediction> toGamePredictionArray(JsonArray jsonArray) {
        List<GamePrediction> predictions = new ArrayList<GamePrediction>();
        for (JsonElement element : jsonArray) {
            predictions.add(Convert.toGamePrediction(element.getAsJsonObject()));
        }

        return predictions;
    }

    public static GamePrediction toGamePrediction(JsonObject element) {
        GamePrediction prediction = new GamePrediction();
        prediction.setGameId(element.get("gameId").getAsInt());
        prediction.setGameDay(element.get("gameDay").getAsString());
        prediction.setGameTime(element.get("gameTime").getAsString());
        prediction.setGameState(element.get("gameState").getAsCharacter());
        prediction.setAwayTeam(element.get("awayAbbr").getAsString());
        prediction.setHomeTeam(element.get("homeAbbr").getAsString());
        prediction.setAwayScore(element.get("awayScore").getAsInt());
        prediction.setHomeScore(element.get("homeScore").getAsInt());
        prediction.setPredictedAwayScore(element.get("predictedAwayScore").getAsInt());
        prediction.setPredictedHomeScore(element.get("predictedHomeScore").getAsInt());
        prediction.setPointsAwarded(element.get("pointsAwarded").getAsInt());

        return prediction;
    }

    public static Drawable toDrawable(Context context, String drawableName) {
        Resources resources = context.getResources();
        final int imageResId = resources.getIdentifier(drawableName, "drawable", context.getPackageName());
        Drawable drawable = context.getResources().getDrawable(imageResId);

        return drawable;
    }

    public static List<Map.Entry<Integer, List<Integer>>> toEntrySet(JsonElement element) {
        List<Map.Entry<Integer, List<Integer>>> result = new ArrayList<Map.Entry<Integer, List<Integer>>>();
        Set<Map.Entry<String, JsonElement>> entrySet = element.getAsJsonObject().entrySet();
        for (Map.Entry<String, JsonElement> entry : entrySet) {
            result.add(new AbstractMap.SimpleEntry<Integer, List<Integer>>(
                    Integer.parseInt(entry.getKey()),
                    toIntegerArray(entry.getValue().getAsJsonArray())
            ));
        }

        return result;
    }

    public static List<Integer> toIntegerArray(JsonArray jsonArray) {
        List<Integer> returnList = new ArrayList<Integer>();
        for (JsonElement element : jsonArray) {
            returnList.add(element.getAsInt());
        }

        return returnList;
    }

    public static Drawable toDrawable(String url) throws IOException {
        return Drawable.createFromStream((InputStream)new URL(url).getContent(), "src");
    }
}
