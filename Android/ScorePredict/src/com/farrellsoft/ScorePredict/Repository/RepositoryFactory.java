package com.farrellsoft.ScorePredict.Repository;

public final class RepositoryFactory
{

    private static WeekRepository _weekRepository;
    public static WeekRepository getWeekRepository() {
        if (_weekRepository == null) {
            _weekRepository = new WeekRepository();
        }

        return _weekRepository;
    }

}
