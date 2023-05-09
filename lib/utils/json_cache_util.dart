import 'dart:core';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/object_util.dart';
import 'dart:convert' as convert;
import 'sp_util.dart';

// 缓存查询 Key = "cache:"+dataType+":"+userId+":"+labelId;
class JsonCacheManageUtils {
  // dataType
  static const int WeekPaperResponse = 0x001;
  static const int PaperCategory = 0x002;
  static const int PaperDetail = 0x003;
  static const int WeekTestListResponse = 0x004;
  static const int WeekTestCatalogResponse = 0x005;
  static const int WeekTestDetailResponse = 0x006;
  static const int APPVERSION = 0x007;
  static const int DATA_GROUP_DETAIL = 0x008;

  // 胡一旭周报列表接口
  static const int WeekListRespose = 0x009;
  static const int WeekDirectoryResponse = 0x00A;
  static const int WeekDetailResponse = 0x00B;
  static const int ErrorNoteResponse = 0x00C;
  static const int ErrorNoteDetailResponse = 0x00D;
  static const int PracticeListDetailResponse = 0x00E;

  static const int StudentListResponse = 0x010;
  static const int JournalListResponse = 0x011;
  static const int HomeworkExamPaperResponse = 0x012;
  static const int HomeworkHistoryResponse = 0x013;
  static const int QuestionListResponse = 0x014;
  static const int ResultListResponse = 0x015;
  static const int JournalExerciseResult = 0x016;

  static const int ReviewHomeResponse = 0x101; //复习界面
  static const int PracRecordInfoResponse = 0x102; //练习记录
  static const int ErrorNateTabList = 0x103; //错题本tab
  static const int SearchRecordDate = 0x104; //收藏筛选
  static const int SearchCollectListDate = 0x105; //收藏列表
  static const int HomeListDate = 0x106; //首页金刚区
  static const int HomeListChoiceDate = 0x107; //金刚区听力筛选
  static const int SecondListDate = 0x108; //听力列表内容
  static const int HomeWeeklyListChoiceDate = 0x109; //周报列表筛选内容
  static const int HomeMyJournalDate = 0x110; //首页我的期刊列表
  static const int HomeMyTasks = 0x111; //首页我的任务
  static const int HomeTopSearch = 0x112; //首页搜索
  static const int HomeTopScan = 0x113; //首页扫一扫班级
  static const int PersonInfo = 0x114; //个人中心个人信息
  static const int PracticeDate = 0x115; //练习记录日期
  static const int SearchRecordDetail = 0x116; //练习记录日期
  static const int WeekDetailResponseFromSUBJECTID = 0x117; //从subjectId获取的试题数据
  static const int HomeKingListNew = 0x118; //金刚区

  //教师端
  static const int HomeKingListNewTeacher = 0x201; //金刚区
  static const int HomeMyJournalDateTeacher = 0x202; //首页我的期刊列表
  static const int HomeMyRecommendation = 0x203; //首页推荐期刊
  static const int HomeMyClassList = 0x204; //我的班级列表
  static const int HomeMyClassDetail = 0x205; //我的班级详情

  // String contentJson;

  // 加载缓存
  static Future<Map?> getCacheData(int dataType, {String? labelId}) async {
    String key = makeKey(dataType, lableId: labelId);
    String result = await SpUtil.getString(key);
    if (!ObjectUtil.isEmpty(result)) {
      Map<String, dynamic>? map = convert.jsonDecode(result);
      return map;
    }
    return null;
  }

  // 存储数据
  static void saveCacheData(int dataType, Map map, {String? labelId}) {
    String key = makeKey(dataType, lableId: labelId);
    String data = convert.jsonEncode(map);
    SpUtil.putString(key, data);
  }

  static String makeKey(int dataType, {String? lableId}) {
    String userId = SpUtil.getString(BaseConstant.userId);
    String key;
    if (lableId == null) {
      key = "cache:" + dataType.toString() + ":" + userId + ":";
    } else {
      key = "cache:" + dataType.toString() + ":" + userId + ":" + lableId;
    }
    return key;
  }
}
