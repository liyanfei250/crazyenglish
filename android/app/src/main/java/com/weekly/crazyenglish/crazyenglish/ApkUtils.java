package com.weekly.crazyenglish.crazyenglish;

import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;


/**
 * Created by wanxiuqi on 2019/7
 * <p>
 * Description：
 */
public class ApkUtils {

    public static boolean checkApkExist(Context context, String packageName) {
        if (TextUtils.isEmpty(packageName)) {
            Log.d("checkApkExist", "" + packageName + "=====isEmpty");
            return false;
        }
        try {
            ApplicationInfo info = context.getPackageManager()
                    .getApplicationInfo(packageName,
                            PackageManager.GET_UNINSTALLED_PACKAGES);
            Log.d("checkApkExist", "" + packageName + "=====" + true);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            Log.d("checkApkExist", "" + packageName + "=====" + false);
            return false;
        }
    }

    public static boolean checkNeedShowMyWorkSelect() {
        if ("xiaomi".equalsIgnoreCase(Build.MANUFACTURER)
        || "nubia".equalsIgnoreCase(Build.MANUFACTURER)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 通过包名 在应用商店打开应用
     *
     * @param packageName 包名
     */
    public static void openApplicationMarket(Context context, String packageName,String url) {
        if (packageName==null||TextUtils.isEmpty(packageName)){
            Toast.makeText(context,"应用对应packageName是空",Toast.LENGTH_SHORT);
            return;
        }
        try {
            String manufacturer = Build.MANUFACTURER;
            Log.e("openApplicationMarket", "Build.MANUFACTURER=======" + manufacturer);

            if ("samsung".equalsIgnoreCase(manufacturer)) {
                Uri uri = Uri.parse("http://www.samsungapps.com/appquery/appDetail.as?appId=" + packageName);
                Intent goToMarket = new Intent();
                goToMarket.setClassName("com.sec.android.app.samsungapps", "com.sec.android.app.samsungapps.Main");
                goToMarket.setData(uri);
                try {
                    context.startActivity(goToMarket);
                } catch (ActivityNotFoundException e) {
//                    ToastUtils.show("打开手机应用商店失败", Gravity.CENTER);
                    e.printStackTrace();
                }
            } else {
                String str = "market://details?id=" + packageName;
                Intent localIntent = new Intent(Intent.ACTION_VIEW);
                localIntent.setData(Uri.parse(str));
                context.startActivity(localIntent);
            }
        } catch (Exception e) {
            // 打开应用商店失败 可能是没有手机没有安装应用市场
            Log.e("openApplicationMarket", "+===" + e.getMessage());
            e.printStackTrace();
            if (url!=null&&!(TextUtils.isEmpty(url))){
                openSystemWeb(context,url);
            }else {
                Toast.makeText(context,"应用对应Url是空",Toast.LENGTH_SHORT);
            }
//            ToastUtils.show("打开应用商店失败", Gravity.CENTER);
            // 调用系统浏览器进入商城
//            String url = "http://app.mi.com/detail/163525?ref=search";
//            Intent intent = new Intent(Intent.ACTION_VIEW);
//            intent.setData(Uri.parse(url));
//            context.startActivity(intent);
        }
    }

    public static void openSystemWeb(Context context, String url) {
        if (TextUtils.isEmpty(url)) {
            return;
        }
        Intent intent = new Intent();
        try {
            intent.setData(Uri.parse(url));
            intent.setAction(Intent.ACTION_VIEW);
            context.startActivity(intent);
        } catch (Exception e) {
            Log.e("开启系统浏览器失败", "url==" + url);
//            ToastUtils.show("开启系统浏览器失败", Gravity.BOTTOM);
        }
    }

}
