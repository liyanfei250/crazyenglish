import '../config.dart';

class Api {
  static String getUser = Config.ApiHost + "/user.site";
  static String getLogin = Config.ApiHost + "/oauth/token";
  static String getPsdLoginNew = "http://82.157.164.83:9000/oauth/token";
  static String getLoginNew = "http://192.168.0.155/app/user/login/sms";
  static String getResetPsdNew = "http://192.168.0.155/app/user/reset/sms";

  static String getSendAuthCodeNew = "http://192.168.0.155/config/sms/put";

  //修改年级信息
  static String getChangeGrade = "http://192.168.0.155/app/user/put";

  //获取用户信息
  static String getUserIofo = "http://82.157.164.83:9000/member/user/";
  static String getSendCode = Config.ApiHost + "/crazy-basic-core/sms/";

  static String getWeekPaperList =
      Config.ApiHost + "/crazy-weekly/periodical/app/page";

  //{periodicaId}
  static String getWeekPaperCategory =
      Config.ApiHost + "/crazy-weekly/periodicalContent/app/list/";

  //{id}
  static String getWeekPaperDetail =
      Config.ApiHost + "/crazy-weekly/periodicalContent/app/selectById/";

  static String getWeekTestList =
      Config.ApiHost + "/crazy-question/exercisePeriodical/app/page";

  static String getWeekTestCategoryList =
      Config.ApiHost + "/crazy-question/exerciseCatalogue/app/list/";

  //{periodicaId}
  static String getWeekTestDetail = Config.ApiHost +
      "/crazy-question/exerciseQuestionRequire/selectAppRequireListVo/";

  // static String getAppVersion = Config.ApiHost +"/crazy-basic-core/appVersion/app/version/";
  static String getAppVersion =
      Config.ApiHost + "/crazy-basic-core/appVersion/app/version/";

  /// CLASS_GRADE 年级
  /// QUESTION_TYPE 题型
  /// QUESTION_DIFFICULTY 题目难度
  /// LISTENING_TYPE 题目类型
  /// LISTENING_MODE 听力类型
  static String getDataGroupDetail =
      Config.ApiHost + "/crazy-basic-core/dataGroupDetail/";

  static String getWeiXinPay = Config.ApiHost + "/weixinpay.site";
  static String getPush = Config.ApiHost + "/push_record.site";
  static String getMobile =
      "https://api.verification.jpush.cn/v1/web/loginTokenVerify";

  // 胡一旭接口
  // 周报列表
  static String getWeeklyList = Config.ApiHost + "/app/weekly/list";

  // 周报目录
  static String getWeeklyDirectory =
      Config.ApiHost + "/app/weekly/directory/tree";


  //根据用户错题本
  static String getErrotList = Config.ApiHost + "/app/exercises/error/weekly";

  //错题本item详情
  static String getErrotListDetail = Config.ApiHost + "/app/exercises/error";

  //获取练习记录目录
  static String getPracticerecords =
      Config.ApiHost + "/app/practicerecords/list/date";

  //获取练习记录详情
  static String getPracticerecordsDetail =
      Config.ApiHost + "/app/practicerecords/exercises";

  // 开始作答接口
  static String getStartExam = Config.ApiHost + "/question/exercise/isFinishByCatalogueId/";

  // 提交答案接口
  static String postWeekCommit = Config.ApiHost + "/question/exercise/submitAnswer";

  // 结果页接口
  static String getExamResult = Config.ApiHost + "/question/exercise/getExerciseResultDetails/";


  // 金刚区接口 // 周报筛选字典接口
  static String getHomeKingList =
      Config.ApiHost + "/question/dictionary/getByType/";

  // 周报列表接口
  static String getHomeWeeklyList =
      Config.ApiHost + "/question/exercise/getWeeklyReoprtsList";

  // 周报目录列表
  static String getHomeWeeklyDirectoryList =
      Config.ApiHost + "/question/exercise/getCatalogueByJournalId/";

  // 周报详情
  static String getWeekDetail = Config.ApiHost + "/question/exercise/getSubDetailsByCatalogueId/";


  //获取复习首页的信息接口
  static String getReviewHomeDetail = Config.ApiHost + "/question/exercise/getReviewTotal/";

  // 练习记录有数据的天数获取
  static String getPracticeDateList = Config.ApiHost + "/question/exercise/getExerciseMonthDate/";
  // 练习记录接口数据
  static String getPracticeRecordList = Config.ApiHost + "/question/exercise/getExerciseRecordList/";

  // 错题本tab接口
  static String getErrorNoteTabDateList = Config.ApiHost + "/";

  // 收藏题目最近搜索历史接口
  static String getSearchRecordDateList = Config.ApiHost + "/";

  // 收藏列表接口
  static String getSearchCollectListDate = Config.ApiHost + "/";

  // 收藏
  static String toCollect = Config.ApiHost + "/question/collected/collectOrCancelQuestion/";

  // 收藏取消
  static String toCancellCollect = Config.ApiHost + "/";

  // 首页金刚区列表
  static String getHomeList = Config.ApiHost + "/";

  // 首页金刚区列表听力筛选条件
  static String getHomeListChoiceDate = Config.ApiHost + "/";

  // 首页金刚区听力列表
  static String getHomeSecondListDate = Config.ApiHost + "/";

  // 首页金刚区周报筛选
  static String getHomeWeeklyChoiceDate = Config.ApiHost + "/";

  // 首页我的期刊列表
  static String getHomeMyJournalListDate = Config.ApiHost + "/";

  // 首页我的任务
  static String getHomeMyTasksDate = Config.ApiHost + "/";

  // 首页顶部搜索
  static String getHomeSearchListDate = Config.ApiHost + "/";

  // 首页扫描班级信息
  static String getHClassInfoDate = Config.ApiHost + "/";

  // 提交反馈信息
  static String postContentDate = Config.ApiHost + "/question/collected/saveFeedback";

  // 获取反馈信息
  static String getContentDate = Config.ApiHost + "/";

  // 提交头像
  static String toPushHeaderImage = Config.ApiHost + "/";

  // 获取个人信息
  static String getPersonInfo = Config.ApiHost + "/";

  // 修改昵称
  static String toChangeNickName = Config.ApiHost + "/";

  // 修改密码
  static String toChangePassword = Config.ApiHost + "/";

  // 修改手机号
  static String toChangePhoneNum = Config.ApiHost + "/";
}
