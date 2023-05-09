
enum Env {
  NEIBU,
  PRODUCT,
  IOS,
}

class Config {
  static Env? env;
  // 内网环境
  static final String NEIBU_APP_ID = "1001";
  static final String NEIBU_SECURITY_KEY = "f6448a1aa06b4779b39549c5f5f0aa32";
  static final String NEIBU_API_DOMAIN = "https://test-api.crazyenglishweekly.com/fkyy";

  // 外网环境
  static final String PRODUCT_APP_ID = "1001";
  static final String PRODUCT_SECURITY_KEY = "5522e1d52361454c9f44eb7db1280f61";
  static final String PRODUCT_API_DOMAIN = "https://api.crazyenglishweekly.com/fkyy";

  static final String TEST_APP_ID = "1001";
  static final String TEST_SECURITY_KEY = "5522e1d52361454c9f44eb7db1280f61";
  static final String TEST_API_DOMAIN = "https://test-api.crazyenglishweekly.com/fkyy";

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
        return TEST_API_DOMAIN;
      default:
        return PRODUCT_API_DOMAIN;
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
