package com.farrellsoft.ScorePredict.Core;

import android.graphics.drawable.Drawable;
import android.os.AsyncTask;
import android.widget.ImageView;

import java.io.IOException;

/**
 * Created by Jason Farrell on 6/12/2014.
 */
public class DownloadImageAsyncTask extends AsyncTask<String, Void, Drawable>
{
    private ImageView mImageView;

    public DownloadImageAsyncTask(ImageView imageView) {
        this.mImageView = imageView;
    }

    @Override
    protected Drawable doInBackground(String... params) {
        if (params.length == 0)
            return null;

        try {
            return Convert.toDrawable(params[0]);
        } catch (IOException e) {
            return null;
        }
    }

    @Override
    protected void onPostExecute(Drawable result) {
        if (result != null) {
            this.mImageView.setImageDrawable(result);
        }
    }
}
