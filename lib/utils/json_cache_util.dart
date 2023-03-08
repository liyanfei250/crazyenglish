
import 'dart:core';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/object_util.dart';
import 'dart:convert' as convert;
import 'sp_util.dart';

// 缓存查询 Key = "cache:"+dataType+":"+userId+":"+labelId;
class JsonCacheManageUtils{

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


  // String contentJson;

  // 加载缓存
  static Future<Map?> getCacheData(int dataType,{String? labelId}) async{
    String key = makeKey(dataType,lableId: labelId);
    String result = await SpUtil.getString(key);
    if(!ObjectUtil.isEmpty(result)){
      Map<String,dynamic>? map = convert.jsonDecode(result);
      return map;
    }
    return null;
  }

  // 存储数据
  static void saveCacheData(int dataType,Map map,{String? labelId}){
    String key = makeKey(dataType,lableId: labelId);
    String data = convert.jsonEncode(map);
    SpUtil.putString(key, data);
  }

  static String makeKey(int dataType,{String? lableId}){
    String userId = SpUtil.getString(BaseConstant.userId);
    String key;
    if(lableId==null){
      key = "cache:"+dataType.toString()+":"+userId+":";
    }else{
      key = "cache:"+dataType.toString()+":"+userId+":"+lableId;
    }
    return key;
  }
}