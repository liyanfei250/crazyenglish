package com.weekly.crazyenglish.crazyenglish

import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat.startActivityForResult
import androidx.core.content.FileProvider
import com.googlecode.eyesfree.utils.LogUtils
import org.robolectric.shadows.ShadowActivityThread.getPackageManager
import java.io.File


/**
 *
 * @ClassName:      UpgradeUtil
 * @Author:         WanXiuQi
 * @CreateDate:     1/14/22 4:03 PM
 * @Description:
 */
public object UpgradeUtil {

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

    /**
     * 安装app，android 7.0及以上和以下方式不同
     */
    public fun startInstall(context: Context, path: String) {
        val file = File(path)
        if (!file.exists()) {
            return
        }

        val intent = Intent(Intent.ACTION_VIEW)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            //7.0及以上

            val contentUri = FileProvider.getUriForFile(context, "${context.packageName}.fileprovider", file)
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intent.setDataAndType(contentUri, "application/vnd.android.package-archive")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val hasInstallPermission: Boolean = org.robolectric.shadows.ShadowActivityThread.getPackageManager().canRequestPackageInstalls()
                if (!hasInstallPermission) {
                    startInstallPermissionSettingActivity()
                    return
                }
            }
            context.startActivity(intent)
        } else {
            //7.0以下
            intent.setDataAndType(Uri.fromFile(file), "application/vnd.android.package-archive")
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(intent)
        }

    }

    /**
     * 跳转到设置-允许安装未知来源-页面
     */
    @RequiresApi(api = Build.VERSION_CODES.O)
    private fun startInstallPermissionSettingActivity() {
        //后面跟上包名，可以直接跳转到对应APP的未知来源权限设置界面。使用startActivityForResult 是为了在关闭设置界面之后，获取用户的操作结果，然后根据结果做其他处理
        val intent = Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, Uri.parse("package:" + getPackageName()))
        startActivityForResult(intent, 1)
    }

    protected fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (resultCode == RESULT_OK) {
            if (requestCode == 1) {
                openAPKFile()
            }
        } else {
            if (requestCode == 1) {
                //CnPeng 2018/8/2 下午4:31 8.0手机位置来源安装权限
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    val hasInstallPermission: Boolean = org.robolectric.shadows.ShadowActivityThread.getPackageManager().canRequestPackageInstalls()
                    if (!hasInstallPermission) {
                        LogUtils.e(TAG, "没有赋予 未知来源安装权限")
                        showUnKnowResourceDialog()
                    }
                }
            } else if (requestCode == 2) {
                // CnPeng 2018/8/2 下午4:31 在安装页面中退出安装了
                LogUtils.e(TAG, "从安装页面回到欢迎页面--拒绝安装")
                showApkInstallDialog()
            }
        }
    }

    /**
     * 作者：CnPeng
     * 时间：2018/8/2 下午6:06
     * 功用：弹窗请安装APP的弹窗
     * 说明：8.0手机升级APK时获取了未知来源权限，并跳转到APK界面后，用户可能会选择取消安装，所以，再给一个弹窗
     */
    private fun showApkInstallDialog() {
        val installDialog = CustomAlertDialog(mActivity)
        installDialog.setCancelable(false)
        val binding: DialogInstallApkBinding = DataBindingUtil.inflate(getLayoutInflater(), R.layout.dialog_install_apk, null, false)
        installDialog.setView(binding.getRoot())
        installDialog.show()
        binding.ivIKnowBt2.setOnClickListener(object : OnClickListener() {
            fun onClick(v: View?) {
                //再次回到安装界面
                openAPKFile()
            }
        })
        binding.tvInstallNext.setOnClickListener(object : OnClickListener() {
            fun onClick(v: View?) {
                installDialog.dismiss()

                //CnPeng 2018/8/2 下午5:28  使用自定义方法关闭全部activity
                ActivitiesCollector.finishAll()
            }
        })
    }

    /**
     * 作者：CnPeng
     * 时间：2018/8/2 下午5:50
     * 功用：未知来源权限弹窗
     * 说明：8.0系统中升级APK时，如果跳转到了 未知来源权限设置界面，并且用户没用允许该权限，会弹出此窗口
     */
    private fun showUnKnowResourceDialog() {
        val alertDialog = CustomAlertDialog(mActivity)
        alertDialog.setCancelable(false)
        val binding: DialogUnknowResourceBinding = DataBindingUtil.inflate(getLayoutInflater(), R.layout.dialog_unknow_resource, null, false)
        alertDialog.setView(binding.getRoot())
        alertDialog.show()
        binding.ivIKnowBt.setOnClickListener(object : OnClickListener() {
            fun onClick(v: View?) {
                //兼容8.0
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    val hasInstallPermission: Boolean = org.robolectric.shadows.ShadowActivityThread.getPackageManager().canRequestPackageInstalls()
                    if (!hasInstallPermission) {
                        startInstallPermissionSettingActivity()
                    }
                }
                alertDialog.dismiss()
            }
        })
    }

}