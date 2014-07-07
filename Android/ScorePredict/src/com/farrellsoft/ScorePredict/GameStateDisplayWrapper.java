package com.farrellsoft.ScorePredict;

public class GameStateDisplayWrapper {
    private String _gameState;

    public GameStateDisplayWrapper(char gameState) {
        _gameState = new Character(gameState).toString();
    }

    @Override
    public String toString() {
        if (_gameState.equalsIgnoreCase("F")) {
            return "Final";
        }

        if (_gameState.equalsIgnoreCase("P")) {
            return "Pregame";
        }

        return "In Progress";
    }
}
