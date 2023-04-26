import 'dart:core';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/object_util.dart';
import 'dart:convert' as convert;
import 'sp_util.dart';

// 缓存查询 Key = "cache:"+dataType+":"+userId+":"+labelId;
class JsonCacheManageUtils {
  // dataType
  static final int WeekPaperResponse = 0x001;
  static final int PaperCategory = 0x002;
  static final int PaperDetail = 0x003;
  static final int WeekTestListResponse = 0x004;
  static final int WeekTestCatalogResponse = 0x005;
  static final int WeekTestDetailResponse = 0x006;
  static final int APPVERSION = 0x007;
  static final int DATA_GROUP_DETAIL = 0x008;

  // 胡一旭周报列表接口
  static final int WeekListRespose = 0x009;
  static final int WeekDirectoryResponse = 0x00A;
  static final int WeekDetailResponse = 0x00B;
  static final int ErrorNoteResponse = 0x00C;
  static final int ErrorNoteDetailResponse = 0x00D;
  static final int PracticeListDetailResponse = 0x00E;

  static final int StudentListResponse = 0x010;
  static final int JournalListResponse = 0x011;
  static final int HomeworkExamPaperResponse = 0x012;
  static final int HomeworkHistoryResponse = 0x013;
  static final int QuestionListResponse = 0x014;
  static final int ResultListResponse = 0x015;

  static final int ReviewHomeResponse = 0x101; //复习界面
  static final int PracRecordInfoResponse = 0x102; //练习记录
  static final int ErrorNateTabList = 0x103; //错题本tab
  static final int SearchRecordDate = 0x104; //收藏筛选
  static final int SearchCollectListDate = 0x105; //收藏列表
  static final int HomeListDate = 0x106; //首页金刚区
  static final int HomeListChoiceDate = 0x107; //金刚区听力筛选
  static final int SecondListDate = 0x108; //听力列表内容
  static final int HomeWeeklyListChoiceDate = 0x109; //周报列表筛选内容
  static final int HomeMyJournalDate = 0x110; //首页我的期刊列表
  static final int HomeMyTasks = 0x111; //首页我的任务
  static final int HomeTopSearch = 0x112; //首页搜索
  static final int HomeTopScan = 0x113; //首页扫一扫班级
  static final int PersonInfo = 0x114; //个人中心个人信息
  static final int PracticeDate = 0x115; //练习记录日期
  static final int SearchRecordDetail = 0x116; //练习记录日期
  static final int WeekDetailResponseFromSUBJECTID = 0x117; //从subjectId获取的试题数据
  static final int HomeKingListNew = 0x118; //金刚区

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
