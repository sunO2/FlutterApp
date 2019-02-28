package com.hezhihu89.flutterdemo;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

/**
 * @author hezhihu89
 * 创建时间 2019 年 02 月 28 日 15:49
 * 功能描述:
 */
public class LauncherAtivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = new Intent(this,MainActivity.class);
        startActivity(intent);
    }
}
