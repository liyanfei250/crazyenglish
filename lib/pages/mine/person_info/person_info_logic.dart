import 'package:get/get.dart';

import '../../../entity/base_resp.dart';
import '../../../entity/home/CommentDate.dart';
import '../../../entity/home/PersonInfo.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../index/HomeViewRepository.dart';
import 'person_info_state.dart';

class Person_infoLogic extends GetxController {
  final Person_infoState state = Person_infoState();
  HomeViewRepository recordData = HomeViewRepository();
  void postImageContent(String id) async {
    CommentDate collectResponse = await recordData.toPushHeaderImage({"mobile": id});
    state.pushDate = collectResponse;
    update([GetBuilderIds.toPushHeaderImage]);
  }

  void getPersonInfo(String id) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.PersonInfo)
        .then((value) {
      if (value != null) {
        return PersonInfo.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is PersonInfo) {
      state.infoDate = cache!;
      hasCache = true;
      update([GetBuilderIds.getPersonInfo]);
    }
    PersonInfo list = await recordData.getPersonInfo({"mobile": id});
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.PersonInfo, list.toJson());
    state.infoDate = list!;
    if (!hasCache) {
      update([GetBuilderIds.getPersonInfo]);
    }
  }
}
