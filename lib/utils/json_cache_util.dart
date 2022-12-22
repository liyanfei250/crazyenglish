
import 'dart:core';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/utils/object_util.dart';
import 'dart:convert' as convert;
import 'sp_util.dart';

// 缓存查询 Key = "cache:"+dataType+":"+userId+":"+labelId;
class JsonCacheManageUtils{

  // dataType
  static final int WeekPaperResponse = 0x01;

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