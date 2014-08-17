package com.farrellsoft.TheScorePredict.Entities;

/**
 * Created by Jason Farrell on 6/19/2014.
 */
public class GamePrediction
{
    private int gameId;
    private String gameDay;
    private String gameTime;
    private char gameState;
    private String awayTeam;
    private String homeTeam;
    private int awayScore;
    private int homeScore;
    private int predictedAwayScore;
    private int predictedHomeScore;
    private int pointsAwarded;

    public int getGameId() {
        return gameId;
    }

    public void setGameId(int gameId) {
        this.gameId = gameId;
    }

    public String getGameDay() {
        return gameDay;
    }

    public void setGameDay(String gameDay) {
        this.gameDay = gameDay;
    }

    public String getGameTime() {
        return gameTime;
    }

    public void setGameTime(String gameTime) {
        this.gameTime = gameTime;
    }

    public char getGameState() {
        return gameState;
    }

    public void setGameState(char gameState) {
        this.gameState = gameState;
    }

    public String getAwayTeam() {
        return awayTeam;
    }

    public void setAwayTeam(String awayTeam) {
        this.awayTeam = awayTeam;
    }

    public String getHomeTeam() {
        return homeTeam;
    }

    public void setHomeTeam(String homeTeam) {
        this.homeTeam = homeTeam;
    }

    public int getAwayScore() {
        return awayScore;
    }

    public void setAwayScore(int awayScore) {
        this.awayScore = awayScore;
    }

    public int getHomeScore() {
        return homeScore;
    }

    public void setHomeScore(int homeScore) {
        this.homeScore = homeScore;
    }

    public int getPredictedAwayScore() {
        return predictedAwayScore;
    }

    public void setPredictedAwayScore(int predictedAwayScore) {
        this.predictedAwayScore = predictedAwayScore;
    }

    public int getPredictedHomeScore() {
        return predictedHomeScore;
    }

    public void setPredictedHomeScore(int predictedHomeScore) {
        this.predictedHomeScore = predictedHomeScore;
    }

    public int getPointsAwarded() {
        return pointsAwarded;
    }

    public void setPointsAwarded(int pointsAwarded) {
        this.pointsAwarded = pointsAwarded;
    }
}
