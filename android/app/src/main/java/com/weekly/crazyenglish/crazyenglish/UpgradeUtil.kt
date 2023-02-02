package com.weekly.crazyenglish.crazyenglish

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.widget.Toast
import io.flutter.plugin.common.MethodChannel
import java.util.*


/**
 *
 * @ClassName:      UpgradeUtil
 * @Author:         WanXiuQi
 * @CreateDate:     1/14/22 4:03 PM
 * @Description:
 */
public object UpgradeUtil {
    /**
     * 获取app信息
     */
    fun getAppInfo(context: Context?, result: MethodChannel.Result) {
        context?.also {
            var packageInfo = it.packageManager.getPackageInfo(it.packageName, 0)
            val map = HashMap<String, String>()
            map["packageName"] = packageInfo.packageName
            map["versionName"] = packageInfo.versionName
            map["versionCode"] = "${packageInfo.versionCode}"
            result.success(map)
        }
    }

    /**
     * 如果手机上安装多个应用市场则弹出对话框，由用户选择进入哪个市场
     */
    fun toMarket(context: Context) {
        try {
            var packageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
            val uri = Uri.parse("market://details?id=${packageInfo.packageName}")
            val goToMarket = Intent(Intent.ACTION_VIEW, uri)
            goToMarket.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(goToMarket)
        } catch (e: ActivityNotFoundException) {
            e.printStackTrace()
            Toast.makeText(context, "您的手机没有安装应用商店", Toast.LENGTH_SHORT).show()
        }
    }

    /**
     * 直接跳转到指定应用市场
     *
     * @param context
     * @param packageName
     */
    fun toMarket(context: Context, marketPackageName: String, marketClassName: String) {
        try {
            var packageInfo = context.packageManager.getPackageInfo(context.packageName, 0)
            val uri = Uri.parse("market://details?id=${packageInfo.packageName}")
            var nameEmpty = marketPackageName == null || marketPackageName.isEmpty()
            var classEmpty = marketClassName == null || marketClassName.isEmpty()
            val goToMarket = Intent(Intent.ACTION_VIEW, uri)
            if (nameEmpty || classEmpty) {
                goToMarket.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            } else {
                goToMarket.setClassName(marketPackageName, marketClassName)
            }
            context.startActivity(goToMarket)
        } catch (e: ActivityNotFoundException) {
            e.printStackTrace()
            Toast.makeText(context, "您的手机没有安装应用商店($marketPackageName)", Toast.LENGTH_SHORT).show()
        }
    }

    /**
     * 获取已安装应用商店的包名列表
     */
    fun getInstallMarket(context: Context,packages: List<String>?): List<String> {
        val pkgs = ArrayList<String>()
        packages?.also {
            for (i in packages.indices) {
                if (isPackageExist(context, packages.get(i))) {
                    pkgs.add(packages.get(i))
                }
            }
        }
        return pkgs
    }

    /**
     * 是否存在当前应用市场
     *
     */
    fun isPackageExist(context: Context, packageName: String?): Boolean {
        val manager = context.packageManager
        val intent = Intent().setPackage(packageName)
        val infos = manager.queryIntentActivities(intent,
                PackageManager.GET_INTENT_FILTERS)
        return if (infos == null || infos.size < 1) {
            false
        } else {
            true
        }
    }


//    /**
//     * 安装app，android 7.0及以上和以下方式不同
//     */
//    public fun startInstall(context: Context, path: String) {
//        val file = File(path)
//        if (!file.exists()) {
//            return
//        }
//
//        val intent = Intent(Intent.ACTION_VIEW)
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
//            //7.0及以上
//
//            val contentUri = FileProvider.getUriForFile(context, "${context.packageName}.fileprovider", file)
//            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
//            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
//            intent.setDataAndType(contentUri, "application/vnd.android.package-archive")
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//                val hasInstallPermission: Boolean = org.robolectric.shadows.ShadowActivityThread.getPackageManager().canRequestPackageInstalls()
//                if (!hasInstallPermission) {
//                    startInstallPermissionSettingActivity()
//                    return
//                }
//            }
//            context.startActivity(intent)
//        } else {
//            //7.0以下
//            intent.setDataAndType(Uri.fromFile(file), "application/vnd.android.package-archive")
//            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//            context.startActivity(intent)
//        }
//
//    }

//    /**
//     * 跳转到设置-允许安装未知来源-页面
//     */
//    @RequiresApi(api = Build.VERSION_CODES.O)
//    private fun startInstallPermissionSettingActivity() {
//        //后面跟上包名，可以直接跳转到对应APP的未知来源权限设置界面。使用startActivityForResult 是为了在关闭设置界面之后，获取用户的操作结果，然后根据结果做其他处理
//        val intent = Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, Uri.parse("package:" + getPackageName()))
//        startActivityForResult(intent, 1)
//    }


}