import 'package:get/get.dart';

import '../../../entity/home/HomeSearchListDate.dart';
import '../../../entity/review/SearchCollectListDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../../repository/HomeViewRepository.dart';
import 'home_search_state.dart';

class Home_searchLogic extends GetxController {
  final Home_searchState state = Home_searchState();
  HomeViewRepository homeViewRepository = HomeViewRepository();

  void getSearchList(
      String keyWord, int type, int userId, int page, int pageSize) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> p = {};
    req['type'] = type;
    req['keyWord'] = keyWord;
    req['userId'] = userId;
    p["current"] = page;
    p["size"] = pageSize;
    req["p"] = p;

    HomeSearchListDate list = await homeViewRepository.getSearchDateList(req);

    if (list!.obj!.journals != null && list!.obj!.journals!.records != null) {

      if (page == 1) {
        state.listJ = list.obj!.journals!.records!;
      } else {
        // state.listJ.clear();
        state.listJ.addAll(list.obj!.journals!.records!);
      }
      if (list.obj!.journals!.records!.length < pageSize) {
        state.hasMorej = false;
      } else {
        state.hasMorej = true;
      }
    } else {
      // if (page == 1) {
      //   state.listJ.clear();
      // }
    }

    if (list!.obj!.students != null && list!.obj!.students!.records != null) {

      if (page == 1) {
        state.listS = list.obj!.students!.records!;
      } else {
        // state.listS.clear();
        state.listS.addAll(list.obj!.students!.records!);
      }
      if (list.obj!.students!.records!.length < pageSize) {
        state.hasMoreS = false;
      } else {
        state.hasMoreS = true;
      }
    }else {
      // if (page == 1) {
      //   state.listS.clear();
      // }
    }
    update([GetBuilderIds.getHomeSearchDate]);
  }
}
