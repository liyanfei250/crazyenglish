package com.weekly.crazyenglish.crazyenglish;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;

import java.io.File;
import java.util.List;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.core.content.FileProvider;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import static android.app.Activity.RESULT_OK;

/**
 * Time: 2022/11/6 19:42
 * Author: leixun
 * Email: leixun33@163.com
 * <p>
 * Description:
 */
public class AppHelperPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    private static final String TAG = "AppHelper";

    private MethodChannel channel;
    private Context mContext = null;
    private Activity mActivity = null;
    private String filePath = "";

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
            if (call.method.equals("hasPermission")) {
                result.success(hasInstallPermission());
            }else if (call.method.equals("requestPersmission")) {
                startInstallPermissionSettingActivity();
            } else if (call.method.equals("install")) {
                //安装app
                filePath = call.argument("path");
                startInstall(mContext, filePath);
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

    /**
     * 安装app，android 7.0及以上和以下方式不同
     */
    public void startInstall(Context context, String path) {
        File file = new File(path);
        if (!file.exists()) {
            return;
        }

        Intent intent = new Intent(Intent.ACTION_VIEW);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            //7.0及以上
            Uri contentUri = FileProvider.getUriForFile(context, mContext.getPackageName()+".fileprovider", file);
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            intent.setDataAndType(contentUri, "application/vnd.android.package-archive");
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                boolean hasInstallPermission = context.getPackageManager().canRequestPackageInstalls();
                if (!hasInstallPermission) {
                    startInstallPermissionSettingActivity();
                    return;
                }
            }

            context.startActivity(intent);
        } else {
            //7.0以下
            intent.setDataAndType(Uri.fromFile(file), "application/vnd.android.package-archive");
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
        }

    }

    private boolean hasInstallPermission(){
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            boolean hasInstallPermission = mContext.getPackageManager().canRequestPackageInstalls();
            return hasInstallPermission;
        }else{
            return true;
        }
    }


    @RequiresApi(api = Build.VERSION_CODES.O)
    private void startInstallPermissionSettingActivity() {
        //后面跟上包名，可以直接跳转到对应APP的未知来源权限设置界面。使用startActivityForResult 是为了在关闭设置界面之后，获取用户的操作结果，然后根据结果做其他处理
        Intent intent = new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, Uri.parse("package:" + mContext.getPackageName()));
        mActivity.startActivityForResult(intent, 1);
    }


    @Override
    public boolean onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        if (resultCode == RESULT_OK) {
            if (requestCode == 1) {
                startInstall(mContext,filePath);
            }
        }
        return false;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.mActivity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        this.mActivity = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        this.mActivity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        this.mActivity = null;
    }
}
