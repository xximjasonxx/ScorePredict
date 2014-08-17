package com.farrellsoft.TheScorePredict.Views;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Typeface;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.view.ViewGroup;
import android.widget.TextView;
import com.farrellsoft.TheScorePredict.R;

public class IconTextView extends TextView {
    private final int CHEVRON_UP_ID = 0;
    private final int CHEVRON_DOWN_ID = 1;
    private final int STAR_ID = 2;
    private final int CHEVRON_BACK_ID = 3;
    private final int CHEVRON_RIGHT_ID = 4;

    public IconTextView(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);

        if (!isInEditMode()) {
            Typeface fontawesomeTypeface = Typeface.createFromAsset(context.getAssets(), "fontawesome.ttf");
            setTypeface(fontawesomeTypeface);

            TypedArray array = context.getTheme().obtainStyledAttributes(attributeSet, R.styleable.IconTextView, 0, 0);
            int arrowId = -1;
            try {
                arrowId = array.getInteger(R.styleable.IconTextView_iconType, -1);
            }
            finally {
                array.recycle();
            }

            setText(getIconCode(arrowId));
        }
    }

    private int getIconCode(int codeId) {
        switch (codeId) {
            case CHEVRON_UP_ID:
                return R.string.up_arrow;
            case CHEVRON_DOWN_ID:
                return R.string.down_arrow;
            case STAR_ID:
                return R.string.star;
            case CHEVRON_BACK_ID:
                return R.string.back_arrow;
            case CHEVRON_RIGHT_ID:
                return R.string.right_arrow;
        }

        return 0;
    }
}
