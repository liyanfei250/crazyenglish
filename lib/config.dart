
enum Env {
  NEIBU,
  PRODUCT,
  IOS,
}

class Config {
  static Env? env;
  // 内网环境
  static const String NEIBU_APP_ID = "1001";
  static const String NEIBU_SECURITY_KEY = "f6448a1aa06b4779b39549c5f5f0aa32";
  static const String NEIBU_BUCKET_NAME = "test-1315843937";
  static const String NEIBU_API_DOMAIN = "https://test-api.crazyenglishweekly.com/fkyy";

  // 外网环境
  static const String PRODUCT_APP_ID = "1001";
  static const String PRODUCT_SECURITY_KEY = "5522e1d52361454c9f44eb7db1280f61";
  static const String PRODUCT_BUCKET_NAME = "prod-1315843937";
  static const String PRODUCT_API_DOMAIN = "https://api.crazyenglishweekly.com/fkyy";

  static const String buglyIosNeibuAppId = "0ba7862846";
  static const String buglyIosProductAppId = "766ea9b5ae";
  static const String buglyAndroidNeibuAppId = "44aea5eaba";
  static const String buglyAndroidProductAppId = "1e465f9807";

  static String get appId {
    switch (env) {
      case Env.NEIBU:
        return NEIBU_APP_ID;
      case Env.PRODUCT:
        return PRODUCT_APP_ID;
      default:
        return PRODUCT_APP_ID;
    }
  }

  static String get getIosBugly{
    switch (env) {
      case Env.NEIBU:
        return buglyIosNeibuAppId;
      case Env.PRODUCT:
        return buglyIosProductAppId;
      case Env.IOS:
        return buglyIosProductAppId;
      default:
        return buglyIosNeibuAppId;
    }
  }

  static String get getAndroidBugly{
    switch (env) {
      case Env.NEIBU:
        return buglyAndroidNeibuAppId;
      case Env.PRODUCT:
        return buglyAndroidProductAppId;
      case Env.IOS:
        return buglyAndroidProductAppId;
      default:
        return buglyAndroidNeibuAppId;
    }
  }

  static String get versionCode{
    return "100";
  }

  static String get versionName{
    return "1.0.0";
  }


  static String get ApiHost {
    switch (env) {
      case Env.NEIBU:
        return NEIBU_API_DOMAIN;
      case Env.PRODUCT:
        return PRODUCT_API_DOMAIN;
      case Env.IOS:
        return PRODUCT_API_DOMAIN;
      default:
        return PRODUCT_API_DOMAIN;
    }
  }

  static String get bucket_NAME {
    switch (env) {
      case Env.NEIBU:
        return NEIBU_BUCKET_NAME;
      case Env.PRODUCT:
        return PRODUCT_BUCKET_NAME;
      case Env.IOS:
        return PRODUCT_BUCKET_NAME;
      default:
        return PRODUCT_BUCKET_NAME;
    }
  }

  static String get security_KEY {
    switch (env) {
      case Env.NEIBU:
        return NEIBU_SECURITY_KEY;
      case Env.PRODUCT:
        return PRODUCT_SECURITY_KEY;
      default:
        return PRODUCT_SECURITY_KEY;
    }
  }
}
