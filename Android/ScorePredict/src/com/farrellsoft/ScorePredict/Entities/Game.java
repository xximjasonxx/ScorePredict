package com.farrellsoft.ScorePredict.Entities;

import java.io.Serializable;

public class Game {
    private int id;
    private String day;
    private String time;
    private char state;
    private String awayTeam;
    private String awayTeamAbbr;
    private String homeTeam;
    private String homeTeamAbbr;
    private int awayScore;
    private int homeScore;
    private int weekNo;
    private int year;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public char getState() {
        return state;
    }

    public void setState(char state) {
        this.state = state;
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

    public int getWeekNo() {
        return weekNo;
    }

    public void setWeekNo(int weekNo) {
        this.weekNo = weekNo;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getHomeTeamAbbr() {
        return homeTeamAbbr;
    }

    public void setHomeTeamAbbr(String homeTeamAbbr) {
        this.homeTeamAbbr = homeTeamAbbr;
    }

    public String getAwayTeamAbbr() {
        return awayTeamAbbr;
    }

    public void setAwayTeamAbbr(String awayTeamAbbr) {
        this.awayTeamAbbr = awayTeamAbbr;
    }

    public boolean hasConcluded() {
        boolean result = new Character(getState()).toString().equalsIgnoreCase("F");
        return result;
    }

    public boolean inPregame() {
        boolean result = new Character(getState()).toString().equalsIgnoreCase("P");
        return result;
    }

    @Override
    public boolean equals(Object other) {
        if (!(other instanceof Game)) {
            return false;
        }

        Game otherGame = (Game) other;
        return otherGame.getId() == getId();
    }
}
