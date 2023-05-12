import '../config.dart';

class Api {
  static String getUser = Config.ApiHost + "/user.site";
  static String getPsdLoginNew = Config.ApiHost+"/oauth/token";
  static String getLoginNew = Config.ApiHost+"/user/login/sms";
  static String getResetPsdNew = Config.ApiHost+"/member/user/login/resettingPasswd";
  static String getMobileExists = Config.ApiHost+"/member/user/login/check/";

  static String getSendAuthCodeNew = Config.ApiHost+"/member/user/login/getCode/";

  //修改年级信息
  static String getChangeGrade = Config.ApiHost+"/app/user/put";

  //获取用户信息
  static String getUserIofo = Config.ApiHost+"/member/user/";
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
  static String getStartExam =
      Config.ApiHost + "/question/exercise/isFinishByCatalogueId/";

  // 练习记录作答数据
  static String getExerciseDetail =
      Config.ApiHost + "/question/exercise/getExerciseDetail/";

  // 提交答案接口
  static String postWeekCommit =
      Config.ApiHost + "/question/exercise/submitAnswer";

  // 结果页接口
  static String getExamResult =
      Config.ApiHost + "/question/exercise/getExerciseResultDetails/";

  // 金刚区接口新增
  static String getHomeKingListNew =
      Config.ApiHost + "/question/exercise/getConfigurationList/";

  // 周报筛选字典接口
  static String getHomeKingList =
      Config.ApiHost + "/question/dictionary/getByType/";

  // 周报列表接口
  static String getHomeWeeklyList =
      Config.ApiHost + "/question/exercise/getWeeklyReoprtsList";

  // 周报目录列表
  static String getHomeWeeklyDirectoryList =
      Config.ApiHost + "/question/exercise/getCatalogueByJournalId/";

  // 周报详情
  static String getWeekDetail =
      Config.ApiHost + "/question/exercise/getSubDetailsByCatalogueId/";

  //获取复习首页的信息接口
  static String getReviewHomeDetail =
      Config.ApiHost + "/question/exercise/getReviewTotal/";

  // 练习记录有数据的天数获取
  static String getPracticeDateList =
      Config.ApiHost + "/question/exercise/getExerciseMonthDate/";

  // 练习记录接口数据
  static String getPracticeRecordList =
      Config.ApiHost + "/question/exercise/getExerciseRecordList";

  // 期刊成绩接口数据
  static String getJournalExerciseResult =
      Config.ApiHost + "/question/exercise/getJournalExerciseResult";

  // 错题本已订正/未订正列表
  static String getErrorNoteTabDateList =
      Config.ApiHost + "/question/collected/getCorrectionList";

  // 收藏题目最近搜索历史接口改成金刚区
  static String getSearchRecordDateList = Config.ApiHost + "/getSearchRecordDateList";

  // 收藏列表接口
  static String getSearchCollectListDate =
      Config.ApiHost + "/question/collected/getCollectedList";

  // 收藏列表详情接口
  static String getSearchCollectListDateDetail =
      Config.ApiHost + "/question/exercise/getSubjectDetails/";

  // 收藏
  static String toCollect =
      Config.ApiHost + "/question/collected/collectOrCancelQuestion/";

  // 题目收藏状态查询
  static String queryQuestionCollect =
      Config.ApiHost + "/question/collected/isCollect";

  // 首页金刚区列表
  static String getHomeList = Config.ApiHost + "/getHomeList";

  // 首页金刚区列表听力筛选条件
  static String getHomeListChoiceDate = Config.ApiHost + "/getHomeListChoiceDate";

  // 首页金刚区听力列表
  static String getHomeSecondListDate =
      Config.ApiHost + "/question/exercise/getListeningExerciseCatalogue";

  // 首页金刚区周报筛选
  static String getHomeWeeklyChoiceDate = Config.ApiHost + "/getHomeWeeklyChoiceDate";

  // 首页我的期刊列表
  static String getHomeMyJournalListDate =
      Config.ApiHost + "/question/exercise/getPurchaseJournal/";

  // 首页我的任务
  static String getHomeMyTasksDate = Config.ApiHost + "/getHomeMyTasksDate";

  // 首页顶部搜索
  static String getHomeSearchListDate = Config.ApiHost + "/getHomeSearchListDate";

  // 首页扫描班级信息
  static String getHClassInfoDate = Config.ApiHost + "/getHClassInfoDate";

  // 提交反馈信息
  static String postContentDate =
      Config.ApiHost + "/question/collected/saveFeedback";

  // 获取反馈信息
  static String getContentDate = Config.ApiHost + "/getContentDate";

  // 提交头像
  static String toPushHeaderImage = Config.ApiHost + "/toPushHeaderImage";

  // 获取个人信息
  static String getPersonInfo = Config.ApiHost + "/getPersonInfo";

  // 修改昵称
  static String toChangeNickName = Config.ApiHost + "/toChangeNickName";

  // 修改密码
  static String toChangePassword = Config.ApiHost + "/toChangePassword";

  // 修改手机号
  static String toChangePhoneNum = Config.ApiHost + "/toChangePhoneNum";

  //教师端
  //首页
  //我的期刊
  static String TeacherHomeMyJournals = Config.ApiHost + "/TeacherHomeMyJournals";

  //待办工作
  static String TeacherHomeMyTodoList = Config.ApiHost + "/TeacherHomeMyTodoList";

  //推荐期刊
  static String TeacherHomeRecommendationJournals = Config.ApiHost + "/TeacherHomeRecommendationJournals";

  //班级列表查询
  static String TeacherClassList =
      Config.ApiHost + "/member/schoolClass/selectList";
  //班级详情查询
  static String TeacherClassDetail =
      Config.ApiHost + "/member/schoolClass/detail/";
  //班级添加
  static String TeacherClassAdd =
      Config.ApiHost + "/member/schoolClass/save";
  //班级delete
  static String TeacherClassDelete =
      Config.ApiHost + "/member/schoolClass/delete/";
  //班级update
  static String TeacherClassChange =
      Config.ApiHost + "/member/schoolClass/update";

  //班级顶部
  static String TeacherClassTop =
      Config.ApiHost + "/question/statistics/detail/";
  //班级底部
  static String TeacherClassBottom =
      Config.ApiHost + "/question/statistics/studentPage";
  //学生加入班级
  static String studentAddClass =
      Config.ApiHost + "/member/classStudent/joinClass";
  //学生详情
  static String studentDetail =
      Config.ApiHost + "/question/statistics/studentDetail/";
  //学生排行
  static String studentRanking =
      Config.ApiHost + "/question/statistics/studentLeaderboards/";
  //学生报告生成
  static String studentReport =
      Config.ApiHost + "/question/statistics/timeInfo";
  //学生作业列表
  static String studentWorkList =
      Config.ApiHost + "/question/operation/student/detailList";
  //待批改主观题列表
  static String getHomeListToCorrect =
      Config.ApiHost + "/";
  //提交作业
  static String toReleaseWorkUrl =
      Config.ApiHost + "/question/operation/submitOperation";
}
