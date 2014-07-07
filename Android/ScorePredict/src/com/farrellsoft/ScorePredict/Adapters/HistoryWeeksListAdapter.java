package com.farrellsoft.ScorePredict.Adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;
import com.farrellsoft.ScorePredict.R;

import java.util.List;

public class HistoryWeeksListAdapter extends ArrayAdapter<Integer>
{
    public HistoryWeeksListAdapter(Context context, List<Integer> objects) {
        super(context, 0, objects);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.navigation_list_item, null);
        }

        // get the view references
        Integer weekValue = getItem(position);
        ((TextView)convertView.findViewById(R.id.text_year)).setText(String.format("Week %d", weekValue));

        return convertView;
    }
}