package com.farrellsoft.ScorePredict.Service;

import android.content.Context;
import com.farrellsoft.ScorePredict.Core.Convert;
import com.farrellsoft.ScorePredict.Factory.ClientFactory;
import com.farrellsoft.ScorePredict.Handlers.IGetMeComplete;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.microsoft.windowsazure.mobileservices.ApiJsonOperationCallback;
import com.microsoft.windowsazure.mobileservices.MobileServiceClient;
import com.microsoft.windowsazure.mobileservices.ServiceFilterResponse;

import java.net.MalformedURLException;

/**
 * Created by Jason Farrell on 6/9/14.
 */
public class FacebookService
{
    public void getMe(Context context, final IGetMeComplete handler) {
        try {
            MobileServiceClient client = ClientFactory.getAuthenticatedClient(context);
            client.invokeApi("me", "GET", null, new ApiJsonOperationCallback() {
                @Override
                public void onCompleted(JsonElement jsonElement, Exception e, ServiceFilterResponse serviceFilterResponse) {
                    if (e == null) {
                        handler.complete(Convert.toFacebookUser(jsonElement.getAsJsonObject()));
                    }
                    else {
                        handler.fail();
                    }
                }
            });
        }
        catch (MalformedURLException ex) {
            handler.fail();
        }
    }
}
