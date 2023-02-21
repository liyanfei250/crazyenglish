


class UpdateUtil{

  String getApkNameByDownloadUrl(String downloadUrl){
    if(downloadUrl.isEmpty){
      return "temp_" + DateTime.now().millisecondsSinceEpoch.toString() + ".apk";
    }else{
      String appName = downloadUrl.substring(downloadUrl.lastIndexOf("/")+1);
      if (!appName.endsWith(".apk")) {
        appName = "temp_" + DateTime.now().millisecondsSinceEpoch.toString() + ".apk";
      }
      return appName;
    }

  }

}