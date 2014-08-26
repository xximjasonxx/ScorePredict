package com.farrellsoft.TheScorePredict.Adapters;

import com.farrellsoft.TheScorePredict.Entities.Game;

public class GameEntry implements IEntry {
    private Game theGame;

    public GameEntry(Game game) {
        theGame = game;
    }

    @Override
    public boolean isSection() {
        return false;
    }

    public String getAwayAbbr() {
        return theGame.getAwayTeamAbbr();
    }

    public String getHomeAbbr() {
        return theGame.getHomeTeamAbbr();
    }

    public int getAwayScore() {
        return theGame.getAwayScore();
    }

    public int getHomeScore() {
        return theGame.getHomeScore();
    }

    public int getId() {
        return theGame.getId();
    }

    public String getTime() {
        return theGame.getTime();
    }

    public char getState() {
        return theGame.getState();
    }

    public int getWeek() {
        return theGame.getWeekNo();
    }

    public int getYear() {
        return theGame.getYear();
    }

    public boolean inPregame() {
        return theGame.inPregame();
    }

    public boolean isConcluded() {
        return theGame.hasConcluded();
    }
}
