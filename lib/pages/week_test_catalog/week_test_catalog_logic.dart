import 'package:crazyenglish/repository/week_test_repository.dart';
import 'package:get/get.dart';

import '../../entity/week_test_catalog_response.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import 'week_test_catalog_state.dart';
import '../../widgets/treeview/models/node.dart' as tree;

class WeekTestCatalogLogic extends GetxController {
  final WeekTestCatalogState state = WeekTestCatalogState();

  final WeekTestRepository weekTestRepository = WeekTestRepository();
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  void getWeekTestCategory(String periodicaId) async{
    // Map<String,String> req= {};
    // // req["weekTime"] = weekTime;
    // var cache = await JsonCacheManageUtils.getCacheData(
    //     JsonCacheManageUtils.WeekTestCatalogResponse,labelId: periodicaId.toString()).then((value){
    //   if(value!=null){
    //     return WeekTestCatalogResponse.fromJson(value as Map<String,dynamic>?);
    //   }
    // });
    //
    // if(cache is WeekTestCatalogResponse) {
    //   state.weekTestCatalogResponse = cache!;
    //   state.nodes = process(state.weekTestCatalogResponse);
    //   update([GetBuilderIds.weekTestCatalogList]);
    // }
    WeekTestCatalogResponse list = await weekTestRepository.getWeekTestCategory(periodicaId);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.WeekTestCatalogResponse,
        labelId: periodicaId,
        list.toJson());
    state.weekTestCatalogResponse = list!;
    state.nodes = process(state.weekTestCatalogResponse);
    update([GetBuilderIds.weekTestCatalogList]);
  }

  List<tree.Node> process(WeekTestCatalogResponse weekTestCatalogResponse){
    List<tree.Node> nodes = [];
    if(weekTestCatalogResponse.data!=null){
      weekTestCatalogResponse.data!.forEach((element) {
        tree.Node parentNode = tree.Node.fromMap(element.toJson());
        nodes.add(parentNode);
      });
    }
    return nodes;
  }
}
