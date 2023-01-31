package com.weekly.crazyenglish.crazyenglish;

import android.app.Activity;
import android.content.Context;

import java.util.List;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * Time: 2022/11/6 19:42
 * Author: leixun
 * Email: leixun33@163.com
 * <p>
 * Description:
 */
public class AppHelperPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {
    private static final String TAG = "AppHelper";

    private MethodChannel channel;
    private Context mContext = null;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        mContext = binding.getApplicationContext();
        channel = new MethodChannel(binding.getBinaryMessenger(), TAG);
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        try{
            if (call.method.equals("checkInstallPermission")) {
//                result.success(canRequestPackageInstalls(activity));
                //跳转设置应用安装权限
            } else if (call.method.equals("setInstallPermission")) {
//                RequestPackageInstalls(activity, result);
                //检查文件完整性
            } else if (call.method.equals("install")) {
                //安装app
                String path = call.argument("path");
                UpgradeUtil.INSTANCE.startInstall(mContext, path);
            } else if (call.method.equals("getInstallMarket")) {
                List<String> packageList = UpgradeUtil.INSTANCE.getInstallMarket(mContext,call.argument("packages"));
                result.success(packageList);
            } else if (call.method.equals("toMarket")) {
                String marketPackageName = call.argument("marketPackageName");
                String marketClassName = call.argument("marketClassName");
                UpgradeUtil.INSTANCE.toMarket(mContext, marketPackageName, marketClassName);
            } else {
                result.notImplemented();
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
