import 'package:crazyenglish/repository/week_test_repository.dart';
import 'package:get/get.dart';

import '../../../entity/week_directory_response.dart';
import '../../../entity/week_test_catalog_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'week_test_catalog_state.dart';
import '../../../widgets/treeview/models/node.dart' as tree;

class WeekTestCatalogLogic extends GetxController {
  final WeekTestCatalogState state = WeekTestCatalogState();

  final WeekTestRepository weekTestRepository = WeekTestRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void getWeekTestCategory(String periodicaId) async{
    Map<String,String> req= {};
    // req["weekTime"] = weekTime;
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.WeekDirectoryResponse,labelId: periodicaId.toString()).then((value){
      if(value!=null){
        return WeekDirectoryResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is WeekDirectoryResponse) {
      state.weekDirectoryResponse = cache!;
      state.nodes = process(state.weekDirectoryResponse);
      update([GetBuilderIds.weekTestCatalogList]);
    }
    WeekDirectoryResponse list = await weekTestRepository.getWeekTestCategory(periodicaId);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.WeekDirectoryResponse,
        labelId: periodicaId,
        list.toJson());
    state.weekDirectoryResponse = list!;
    state.nodes = process(state.weekDirectoryResponse);
    update([GetBuilderIds.weekTestCatalogList]);
  }

  List<tree.Node> process(WeekDirectoryResponse weekDirectoryResponse){
    List<tree.Node> nodes = [];
    if(weekDirectoryResponse.obj!=null){
      weekDirectoryResponse.obj!.forEach((element) {
        tree.Node parentNode = tree.Node.fromMap(element.toJson());
        nodes.add(parentNode);
      });
    }
    return nodes;
  }
}
