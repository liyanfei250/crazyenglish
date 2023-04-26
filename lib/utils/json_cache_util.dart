import 'dart:core';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/object_util.dart';
import 'dart:convert' as convert;
import 'sp_util.dart';

// 缓存查询 Key = "cache:"+dataType+":"+userId+":"+labelId;
class JsonCacheManageUtils {
  // dataType
  static final int WeekPaperResponse = 0x01;
  static final int PaperCategory = 0x02;
  static final int PaperDetail = 0x03;
  static final int WeekTestListResponse = 0x04;
  static final int WeekTestCatalogResponse = 0x05;
  static final int WeekTestDetailResponse = 0x06;
  static final int APPVERSION = 0x07;
  static final int DATA_GROUP_DETAIL = 0x08;

  // 胡一旭周报列表接口
  static final int WeekListRespose = 0x09;
  static final int WeekDirectoryResponse = 0x0A;
  static final int WeekDetailResponse = 0x0B;
  static final int ErrorNoteResponse = 0x0C;
  static final int ErrorNoteDetailResponse = 0x0D;
  static final int PracticeListDetailResponse = 0x0E;

  static final int StudentListResponse = 0x10;
  static final int JournalListResponse = 0x11;
  static final int HomeworkExamPaperResponse = 0x12;
  static final int HomeworkHistoryResponse = 0x13;
  static final int QuestionListResponse = 0x14;
  static final int ResultListResponse = 0x15;

  static final int ReviewHomeResponse = 0x001; //复习界面
  static final int PracRecordInfoResponse = 0x002; //练习记录
  static final int ErrorNateTabList = 0x003; //错题本tab
  static final int SearchRecordDate = 0x004; //收藏筛选
  static final int SearchCollectListDate = 0x005; //收藏列表
  static final int HomeListDate = 0x006; //首页金刚区
  static final int HomeListChoiceDate = 0x007; //金刚区听力筛选
  static final int SecondListDate = 0x008; //听力列表内容
  static final int HomeWeeklyListChoiceDate = 0x009; //周报列表筛选内容
  static final int HomeMyJournalDate = 0x010; //首页我的期刊列表
  static final int HomeMyTasks = 0x011; //首页我的任务
  static final int HomeTopSearch = 0x012; //首页搜索
  static final int HomeTopScan = 0x013; //首页扫一扫班级
  static final int PersonInfo = 0x014; //个人中心个人信息
  static final int PracticeDate = 0x015; //练习记录日期
  static final int SearchRecordDetail = 0x016; //练习记录日期
  static final int WeekDetailResponseFromSUBJECTID = 0x017; //从subjectId获取的试题数据

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
