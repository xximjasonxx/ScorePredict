package com.farrellsoft.TheScorePredict.Views;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.TextView;
import com.farrellsoft.TheScorePredict.R;

public class RegisteredTextView extends TextView {
    public RegisteredTextView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public void setRegisteredText(String textValue) {
        String trademarkSymbol = getContext().getString(R.string.registeredTrademarkSymbol);
        setText(textValue + " " + trademarkSymbol);
    }
}
