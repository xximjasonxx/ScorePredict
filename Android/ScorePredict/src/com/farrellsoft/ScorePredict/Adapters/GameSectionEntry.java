package com.farrellsoft.ScorePredict.Adapters;

public class GameSectionEntry implements IEntry {
    private String _sectionName;

    public GameSectionEntry(String sectionName) {
        _sectionName = sectionName;
    }

    @Override
    public boolean isSection() {
        return true;
    }

    public String getSectionName() {
        return _sectionName;
    }

}
