import 'package:crazyenglish/repository/week_test_repository.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';
import '../../../entity/week_test_detail_response.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/getx_ids.dart';
import '../../../routes/routes_utils.dart';
import '../../../utils/json_cache_util.dart';
import 'week_test_detail_state.dart';

class WeekTestDetailLogic extends GetxController {
  final WeekTestDetailState state = WeekTestDetailState();

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

  void getDetailAndStartExam(String id,{bool? enterResult = false,bool? isOffCurrentPage = false}) async {
    WeekDetailResponse weekDetailResponse = await getWeekTestDetail(id);
    if(weekDetailResponse!=null){
      getStartExam(id,enterResult: enterResult,isOffCurrentPage: isOffCurrentPage);
    } else {
      Util.toast("获取试题详情数据失败");
    }
  }

  // 获取试题详情页数据
  Future<WeekDetailResponse> getWeekTestDetail(String id) async{
    var cache = await JsonCacheManageUtils.getCacheData(
        JsonCacheManageUtils.WeekDetailResponse,labelId: id.toString()).then((value){
      if(value!=null){
        return WeekDetailResponse.fromJson(value as Map<String,dynamic>?);
      }
    });

    if(cache is WeekTestDetailResponse) {
      state.weekTestDetailResponse = cache!;
      state.uuid = id;
      getWeekTestDetailFromServer(id);
      return cache!;
    }
    return getWeekTestDetailFromServer(id);
  }

  Future<WeekDetailResponse> getWeekTestDetailFromServer(String id) async{
    WeekDetailResponse list = await weekTestRepository.getWeekTestDetail(id);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.WeekDetailResponse,
        labelId: id,
        list.toJson());
    state.weekTestDetailResponse = list!;
    state.uuid = id;
    return list;
  }

  void getStartExam(String id,{bool? enterResult = false,bool? isOffCurrentPage = false}) async{
    StartExam startExam = await weekTestRepository.getStartExam(id);
    state.startExam = startExam;
    state.uuid = id;
    state.enterResult = enterResult??false;
    state.isOffCurrentPage = isOffCurrentPage??false;
    update([GetBuilderIds.startExam]);
  }


  // 添加跳转题目详情监听
  // 所有的跳转答题进结果页都走这里
  // TODO 完善跳结果页流程
  // TODO 引入的地方需要处理监听的添加与删除逻辑
  void addJumpToDetailListen(int parentIndex,int childIndex){
    addListenerId(GetBuilderIds.startExam, () {
      // TODO 区分一下 写作 还是 其它题
      if (state.weekTestDetailResponse != null &&
          state.weekTestDetailResponse.data != null &&
          state.weekTestDetailResponse.data!.length > 0 &&
          state.weekTestDetailResponse.data![0].type == 4 &&
          state.weekTestDetailResponse.data![0].typeChildren == 1) {

        if(state.isOffCurrentPage){
          RouterUtil.offAndToNamed(AppRoutes.WritingPage,
              arguments: {"detail": state.weekTestDetailResponse});
        }else{
          RouterUtil.toNamed(AppRoutes.WritingPage,
              arguments: {"detail": state.weekTestDetailResponse});
        }

      } else {
        // TODO state.startExam 开始作答数据可在此处理
        if(state.isOffCurrentPage){
          RouterUtil.offAndToNamed(AppRoutes.AnsweringPage,
              arguments: {"detail": state.weekTestDetailResponse,
                "uuid":state.uuid,
                "parentIndex":parentIndex,
                "childIndex":childIndex,
              });
        }else{
          RouterUtil.toNamed(AppRoutes.AnsweringPage,
              arguments: {"detail": state.weekTestDetailResponse,
                "uuid":state.uuid,
                "parentIndex":parentIndex,
                "childIndex":childIndex,
              });
        }

      }
    });
  }

}
