package org.anedroid.testapp;

import android.app.Activity;
import android.os.Bundle;

import org.anedroid.testapp.R;

public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
