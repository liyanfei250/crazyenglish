import 'package:get/get.dart';

import '../../../entity/home/HomeKingDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../../repository/other_repository.dart';
import '../../../repository/ReviewRepository.dart';
import 'choose_question_state.dart';
import '../../../../entity/review/HomeSecondListDate.dart' as data;

class ChooseQuestionLogic extends GetxController {
  final ChooseQuestionState state = ChooseQuestionState();
  ReviewRepository reviewRepository = ReviewRepository();
  OtherRepository listData = OtherRepository();
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  void getChoiceMap(String dictionaryType) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeListChoiceDate,
        labelId: dictionaryType.toString())
        .then((value) {
      if (value != null) {
        return HomeKingDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingDate) {
      state.paperDetail = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeListChoiceDate]);
    }
    HomeKingDate list = await listData.getDictionaryDataByType(dictionaryType);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListChoiceDate, labelId: dictionaryType, list.toJson());
    state.paperDetail = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeListChoiceDate]);
    }
  }

  void getHomeList(String type) async {
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.HomeListDate)
        .then((value) {
      if (value != null) {
        return HomeKingDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingDate) {
      state.tabList = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeDateList]);
    }
    HomeKingDate list = await reviewRepository.getHomeKingList(type);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListDate, list.toJson());
    state.tabList = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeDateList]);
    }
  }

  void getQuestionList(int userId, dynamic classifyTypeValue,dynamic affiliatedGrade,
      int size, int current) async {
    Map<String, dynamic> req = {};
    Map<String, dynamic> reqTwo = {};
    req["userId"] = userId;
    req["dictionaryId"] = classifyTypeValue;
    req["affiliatedGrade"] = affiliatedGrade;
    reqTwo["size"] = size;
    reqTwo["current"] = current;
    req["p"] = reqTwo;

    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.SecondListDate,
        labelId: classifyTypeValue.toString())
        .then((value) {
      if (value != null) {
        return data.HomeSecondListDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    state.pageNo = current;
    if (current == 1 && cache?.obj != null && cache!.obj is data.Obj) {
      state.homeSecondListDate = cache!.obj!;
      if (state.homeSecondListDate.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
      state.homeFinalListDate = extractCatalogueRecordVoLists(cache);

      update(
          [GetBuilderIds.getHomeSecondListDate + classifyTypeValue.toString()]);
    }

    data.HomeSecondListDate list = await listData.getListnerList(req);
    if (current == 1) {
      JsonCacheManageUtils.saveCacheData(
          JsonCacheManageUtils.SecondListDate,
          labelId: classifyTypeValue.toString(),
          list.toJson());
    }
    if (list.obj == null) {
      if (current == 1) {
        state.homeSecondListDate.clear();
        state.homeFinalListDate.clear();
      }
    } else {
      if (current == 1) {
        state.homeSecondListDate = list.obj!;
        state.homeFinalListDate = extractCatalogueRecordVoLists(list);
      } else {
        state.homeSecondListDate.addAll(list.obj!);
        state.homeFinalListDate.addAll(extractCatalogueRecordVoLists(list));
      }
      if (list.obj!.length < size) {
        state.hasMore = false;
      } else {
        state.hasMore = true;
      }
    }
    update(
        [GetBuilderIds.getHomeSecondListDate + classifyTypeValue.toString()]);
  }

  List<data.CatalogueRecordVoList> extractCatalogueRecordVoLists(data.HomeSecondListDate homeSecondListDate) {
    List<data.CatalogueRecordVoList> newList = [];

    // 遍历obj列表
    for (data.Obj obj in homeSecondListDate.obj!) {
      // 遍历catalogueMergeVo列表
      for (data.CatalogueMergeVo catalogueMergeVo in obj.catalogueMergeVo!) {
        // 将catalogueRecordVoList中的元素添加到新列表中
        newList.addAll(catalogueMergeVo.catalogueRecordVoList!);
      }
    }

    return newList;
  }
}
