package com.farrellsoft.TheScorePredict.Service;

import android.content.Context;
import android.util.Pair;
import com.farrellsoft.TheScorePredict.Core.Convert;
import com.farrellsoft.TheScorePredict.Handlers.IWeekLoadComplete;
import com.farrellsoft.TheScorePredict.Entities.Week;
import com.farrellsoft.TheScorePredict.Factory.ClientFactory;
import com.farrellsoft.TheScorePredict.Repository.RepositoryFactory;
import com.farrellsoft.TheScorePredict.Repository.WeekRepository;
import com.google.gson.JsonElement;
import com.microsoft.windowsazure.mobileservices.ApiJsonOperationCallback;
import com.microsoft.windowsazure.mobileservices.MobileServiceClient;
import com.microsoft.windowsazure.mobileservices.ServiceFilterResponse;

import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class WeekService
{
    public void loadWeek(final String dateString, Context context, final IWeekLoadComplete completeHandler) {
        final WeekRepository repo = RepositoryFactory.getWeekRepository();
        Week week = repo.getWeek(dateString);

        if (week != null) {
            completeHandler.onComplete(true, "", week);
            return;
        }

        List<Pair<String, String>> parameters = new ArrayList<Pair<String, String>>();
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
        parameters.add(new Pair<String, String>("weekForDate", sdf.format(new Date())));

        try {
            MobileServiceClient client = ClientFactory.getAuthenticatedClient(context);
            client.invokeApi("weekFor", "GET", parameters, new ApiJsonOperationCallback() {
                @Override
                public void onCompleted(JsonElement jsonElement, Exception e, ServiceFilterResponse serviceFilterResponse) {
                    if (e != null) {
                        completeHandler.onComplete(false, e.getMessage(), null);
                    }
                    else {
                        Week week = Convert.toWeek(jsonElement.getAsJsonObject());
                        repo.addWeek(dateString, week);
                        completeHandler.onComplete(true, "", week);
                    }
                }
            });
        } catch (MalformedURLException e) {
            completeHandler.onComplete(false, "Connection Failed", null);
        } catch (Exception ex) {
            completeHandler.onComplete(false, ex.getMessage(), null);
        }
    }

    public void clearWeek(String weekString) {
        final WeekRepository repo = RepositoryFactory.getWeekRepository();
        repo.clearWeek(weekString);
    }
}
