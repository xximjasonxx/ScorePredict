package com.farrellsoft.TheScorePredict;

import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.*;
import android.support.v4.widget.DrawerLayout;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import com.farrellsoft.TheScorePredict.Core.ApplicationContext;
import com.farrellsoft.TheScorePredict.Entities.FacebookUser;
import com.farrellsoft.TheScorePredict.Entities.User;
import com.farrellsoft.TheScorePredict.Factory.UserFactory;
import com.farrellsoft.TheScorePredict.Fragment.FragmentFactory;
import com.farrellsoft.TheScorePredict.Handlers.IGetMeComplete;
import com.farrellsoft.TheScorePredict.Service.FacebookService;

public class MainActivity extends FragmentActivity implements IMainActivity
{
    private String[] mNavigationItems;
    private DrawerLayout mDrawerLayout;
    private ListView mDrawerList;
    private ActionBarDrawerToggle mDrawerToggle;
    private ProgressDialog progressDialog;

    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main_layout);

        User storedUser = UserFactory.getStoredUser(this);
        if (storedUser == null) {
            goToLoginActivity();
            finish();
        }
        else {
            if (ApplicationContext.get_currentInstance().getCurrentUser() == null) {
                FacebookService service = new FacebookService();
                service.getMe(getContext(), new IGetMeComplete() {
                    @Override
                    public void complete(FacebookUser currentUser) {
                        ApplicationContext.get_currentInstance().setCurrentUser(currentUser);
                    }

                    @Override
                    public void fail() {
                        ActivityHelper.displayErrorMessage(getContext(), "Failed to get Current User");
                    }
                });
            }
        }

        mNavigationItems = getResources().getStringArray(R.array.navItems);
        buildNavigationDrawer();

        getActionBar().setDisplayHomeAsUpEnabled(true);
        getActionBar().setHomeButtonEnabled(true);
        selectItem(0);
    }

    private void buildNavigationDrawer() {
        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        mDrawerList = (ListView) findViewById(R.id.left_drawer);

        mDrawerList.setAdapter(new ArrayAdapter<String>(this, R.layout.drawer_list_item, mNavigationItems));
        mDrawerList.setOnItemClickListener(new ListView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                selectItem(position);
            }
        });

        mDrawerToggle = new ActionBarDrawerToggle(
                this,
                mDrawerLayout,
                R.drawable.ic_drawer,
                R.string.drawer_open,
                R.string.drawer_close
        ) {
            public void onDrawerClosed(View view) {
                invalidateOptionsMenu();
            }

            public void onDrawerOpened(View drawerView) {
                invalidateOptionsMenu();
            }
        };

        mDrawerLayout.setDrawerListener(mDrawerToggle);
        mDrawerToggle.syncState();
    }

    private void selectItem(int position) {
        Fragment fragment = FragmentFactory.getFragment(position, this);
        switchFragment(fragment, 0, 0);

        mDrawerList.setItemChecked(position, true);
        setTitle(mNavigationItems[position]);
        mDrawerLayout.closeDrawer(mDrawerList);
    }

    private void goToLoginActivity() {
        Intent intent = new Intent(this, LoginActivity.class);
        startActivity(intent);
        finish();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.main, menu);

        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (mDrawerToggle.onOptionsItemSelected(item)) {
            return true;
        }

        switch (item.getItemId()) {
            case R.id.action_logout:
                executeLogout();
                break;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void setTitle(String title) {
        getActionBar().setTitle(title);
    }

    @Override
    public void showProgress() {
        progressDialog = ProgressDialog.show(this, "", "Loading...", true);
    }

    @Override
    public void hideProgress() {
        if (progressDialog != null)
            progressDialog.hide();
    }

    public void switchFragment(Fragment fragment, int enterAnimation, int exitAnimation) {
        FragmentManager fragmentManager = getSupportFragmentManager();
        FragmentTransaction transaction= fragmentManager.beginTransaction();

        if (enterAnimation > 0 && exitAnimation > 0) {
            transaction.setCustomAnimations(enterAnimation, exitAnimation);
        }

        transaction.addToBackStack(null);
        transaction.replace(R.id.content_frame, fragment).commit();
    }

    public void executeLogout() {
        AlertDialog.Builder alert = new AlertDialog.Builder(getContext());
        alert.setTitle("Confirm Exit").setMessage("Do you wish to exit the application?")
                .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        UserFactory.clearLogin(getContext());

                        Intent intent = new Intent(getContext(), LoginActivity.class);
                        startActivity(intent);
                        finish();
                    }
                }).setNegativeButton("No", null).show();
    }

    public Context getContext() {
        return this;
    }
}