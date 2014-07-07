package com.farrellsoft.ScorePredict.Factory;

import android.content.Context;
import android.content.SharedPreferences;
import com.farrellsoft.ScorePredict.Entities.User;
import com.microsoft.windowsazure.mobileservices.MobileServiceClient;
import com.microsoft.windowsazure.mobileservices.MobileServiceUser;

import java.net.MalformedURLException;

public final class ClientFactory {

    public static MobileServiceClient getClient(Context context) throws MalformedURLException {
        return new MobileServiceClient("https://scorepredict.azure-mobile.net/", "pqhtjENleiEBDldYJmbyXsmVAUkvnI93", context);
    }

    public static MobileServiceClient getAuthenticatedClient(Context context) throws MalformedURLException {
        MobileServiceClient client = getClient(context);
        User storedUser = UserFactory.getStoredUser(context);

        if (storedUser != null) {
            MobileServiceUser user = new MobileServiceUser(storedUser.getUserId());
            user.setAuthenticationToken(storedUser.getToken());
            client.setCurrentUser(user);
        }

        return client;
    }

}