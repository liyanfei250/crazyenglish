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

    var cache = await JsonCacheManageUtils.getCacheData(
      JsonCacheManageUtils.HomeTopSearch,
    ).then((value) {
      if (value != null) {
        return HomeSearchListDate.fromJson(value as Map<String, dynamic>);
      }
    });

    state.pageNo = page;
    if (page == 1 && cache is HomeSearchListDate && cache != null) {
      if (cache!.obj!.journals != null &&
          cache!.obj!.journals!.records != null) {
        state.listJ = cache!.obj!.journals!.records!;
        if (state.listJ.length < pageSize) {
          state.hasMore = false;
        } else {
          state.hasMore = true;
        }
      }
      if (cache!.obj!.students != null &&
          cache!.obj!.students!.records != null) {
        state.listS = cache!.obj!.students!.records!;
        if (state.listS.length < pageSize) {
          state.hasMore = false;
        } else {
          state.hasMore = true;
        }
      }
      update([GetBuilderIds.getHomeSearchDate]);
    }

    HomeSearchListDate list = await homeViewRepository.getSearchDateList(req);
    if (page == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.HomeTopSearch, list.toJson());
    }
//TODO 分页处理后面做
    // if (list.obj!.journals == null) {
    //   if (page == 1) {
    //     state.listJ.clear();
    //   }
    // } else {
    //   if (page == 1) {
    //     state.listJ = list.obj!.journals!.records!;
    //   } else {
    //     state.listJ.addAll(list.obj!.journals!.records!);
    //   }
    //   if (list.obj!.journals!.records!.length < pageSize) {
    //     state.hasMore = false;
    //   } else {
    //     state.hasMore = true;
    //   }
    // }
    //
    // if (list.obj!.students == null) {
    //   if (page == 1) {
    //     state.listS.clear();
    //   }
    // } else {
    //   if (page == 1) {
    //     state.listS = list.obj!.students!.records!;
    //   } else {
    //     state.listS.addAll(list.obj!.students!.records!);
    //   }
    //   if (list.obj!.students!.records!.length < pageSize) {
    //     state.hasMore = false;
    //   } else {
    //     state.hasMore = true;
    //   }
    // }

    update([GetBuilderIds.getHomeSearchDate]);
  }
}
