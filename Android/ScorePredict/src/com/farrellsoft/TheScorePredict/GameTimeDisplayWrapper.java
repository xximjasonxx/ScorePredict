package com.farrellsoft.TheScorePredict;

public class GameTimeDisplayWrapper {
    private String timeString;

    public GameTimeDisplayWrapper(String gameTimeString) {
        timeString = gameTimeString;
    }

    @Override
    public String toString() {
        return timeString.replace(":", "") + "pm";
    }
}
