package com.farrellsoft.TheScorePredict;

public class PredictionDisplayWrapper {
    private String homeTeamAbbr;
    private String awayTeamAbbr;
    private int predictedHomeTeamScore;
    private int predictedAwayTeamScore;

    public PredictionDisplayWrapper(String homeAbbr, String awayAbbr, int homeScore, int awayScore) {
        this.homeTeamAbbr = homeAbbr;
        this.awayTeamAbbr = awayAbbr;
        this.predictedHomeTeamScore = homeScore;
        this.predictedAwayTeamScore = awayScore;
    }

    @Override
    public String toString() {
        if (predictedAwayTeamScore > predictedHomeTeamScore) {
            return String.format("Predicted %s to beat %s %d to %d", awayTeamAbbr.toUpperCase(),
                    homeTeamAbbr.toUpperCase(), predictedAwayTeamScore, predictedHomeTeamScore);
        }

        if (predictedHomeTeamScore > predictedAwayTeamScore) {
            return String.format("Predicted %s to beat %s %d to %d", homeTeamAbbr.toUpperCase(),
                    awayTeamAbbr.toUpperCase(), predictedHomeTeamScore, predictedAwayTeamScore);
        }

        return "Predicted Teams to Tie";
    }
}
