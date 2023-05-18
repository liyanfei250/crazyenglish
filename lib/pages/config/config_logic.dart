import 'package:crazyenglish/entity/home/HomeKingDate.dart';
import 'package:get/get.dart';

import '../../entity/datagroup_detail_response.dart';
import '../../repository/other_repository.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import 'config_state.dart';

class ConfigLogic extends GetxController {
  final ConfigState state = ConfigState();

  OtherRepository otherRepository = OtherRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getConfig() async {
    /// CLASS_GRADE 年级
    /// QUESTION_TYPE 题型
    /// QUESTION_DIFFICULTY 题目难度
    /// LISTENING_TYPE 题目类型
    /// LISTENING_MODE 听力类型

    HomeKingDate groupCLASS_GRADE = await _getGroupDetail("CLASS_GRADE");
    HomeKingDate groupQUESTION_TYPE = await _getGroupDetail("QUESTION_TYPE");
    HomeKingDate groupQUESTION_DIFFICULTY = await _getGroupDetail("QUESTION_DIFFICULTY");
    HomeKingDate groupLISTENING_TYPE = await _getGroupDetail("LISTENING_TYPE");
    HomeKingDate groupLISTENING_MODE = await _getGroupDetail("LISTENING_MODE");

    if(groupCLASS_GRADE!=null
        && groupQUESTION_TYPE!=null
    && groupQUESTION_DIFFICULTY!=null
    && groupLISTENING_TYPE!=null
    && groupLISTENING_MODE!=null){
      state.groupCLASS_GRADE = groupCLASS_GRADE;
      state.groupQUESTION_TYPE = groupQUESTION_TYPE;
      state.groupQUESTION_DIFFICULTY= groupQUESTION_DIFFICULTY;
      state.groupLISTENING_TYPE = groupLISTENING_TYPE;
      state.groupLISTENING_MODE = groupLISTENING_MODE;
      update([GetBuilderIds.datagroupDetailResponse]);
    }
  }

  Future<HomeKingDate> _getGroupDetail(String code) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.DATA_GROUP_DETAIL,labelId: code).then((value){
      if(value!=null){
        return HomeKingDate.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is HomeKingDate) {
      _getGroupDetailByNet(code);
      return cache;
    } else {
      print("${code} not cached");
    }
    HomeKingDate list = await _getGroupDetailByNet(code);
    return list;
  }

  Future<HomeKingDate> _getGroupDetailByNet(String code) async{
    HomeKingDate list = await otherRepository.getDictionaryDataByType(code);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.DATA_GROUP_DETAIL,
        labelId: code,
        list.toJson());
    return list;
  }


}
