package com.farrellsoft.ScorePredict;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import com.farrellsoft.ScorePredict.Factory.ClientFactory;
import com.farrellsoft.ScorePredict.Factory.UserFactory;
import com.microsoft.windowsazure.mobileservices.*;

import java.net.MalformedURLException;

public class LoginActivity extends Activity {
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.login);

        findViewById(R.id.fbLogin).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                performLogin();
            }
        });
    }

    private void performLogin() {
        try {
            MobileServiceClient client = ClientFactory.getClient(getContext());
            client.login(MobileServiceAuthenticationProvider.Facebook, new UserAuthenticationCallback() {
                @Override
                public void onCompleted(MobileServiceUser mobileServiceUser, Exception e, ServiceFilterResponse serviceFilterResponse) {
                    if (e != null) {
                        ActivityHelper.displayErrorMessage(getContext(), "Login to Facebook Failed");
                    }
                    else {
                        UserFactory.setStoredUser(getContext(), mobileServiceUser.getUserId(), mobileServiceUser.getAuthenticationToken());
                        goToHomeActivity();
                    }
                }
            });

        } catch (MalformedURLException e) {
            // todo: show an error message in the case this exception is thrown
        }
    }

    private Context getContext() {
        return this;
    }

    private void goToHomeActivity() {
        Intent intent = new Intent(getContext(), MainActivity.class);
        startActivity(intent);
        finish();

    }
}