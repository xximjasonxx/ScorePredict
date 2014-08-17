package com.farrellsoft.TheScorePredict.Entities;

import com.google.gson.annotations.Expose;

public class Prediction {
    @Expose private int id;
    @Expose private int gameId;
    @Expose private int homeTeamScore;
    @Expose private int awayTeamScore;

    transient int pointsAwarded;

    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public int getHomeTeamScore() {
        return homeTeamScore;
    }

    public void setHomeTeamScore(int homeTeamScore) {
        this.homeTeamScore = homeTeamScore;
    }

    public int getAwayTeamScore() {
        return awayTeamScore;
    }

    public void setAwayTeamScore(int awayTeamScore) {
        this.awayTeamScore = awayTeamScore;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPointsAwarded() {
        return pointsAwarded;
    }

    public void setPointsAwarded(int pointsAwarded) {
        this.pointsAwarded = pointsAwarded;
    }

    @Override
    public boolean equals(Object incomingObject) {
        if (incomingObject instanceof Prediction) {
            Prediction pred = (Prediction) incomingObject;
            return this.getId() == pred.getId();
        }

        return false;
    }

    @Override
    public int hashCode() {
        return getId();
    }
}
