package com.farrellsoft.ScorePredict.Adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;
import com.farrellsoft.ScorePredict.R;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HistoryYearsListAdapter extends ArrayAdapter<Map.Entry<Integer, List<Integer>>>
{
    public HistoryYearsListAdapter(Context context, List<Map.Entry<Integer, List<Integer>>> objects) {
        super(context, 0, objects);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.navigation_list_item, null);
        }

        // get the view references
        Map.Entry<Integer, List<Integer>> selection = getItem(position);
        ((TextView)convertView.findViewById(R.id.text_year)).setText(selection.getKey().toString());

        return convertView;
    }
}
