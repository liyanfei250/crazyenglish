import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/common.dart';
import '../../../entity/assign_homework_request.dart';
import '../../../entity/common_response.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import '../../../utils/sp_util.dart';
import '../../mine/ClassRepository.dart';
import 'assign_homework_state.dart';
import '../../../base/common.dart' as common;

class AssignHomeworkLogic extends GetxController {
  final AssignHomeworkState state = AssignHomeworkState();
  ClassRepository netTool = ClassRepository();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // tips:
  // 选择的信息实时更改，
  // 但 paperType 只在 二级页面点了确定之后才会更改
  void updateAssignHomeworkRequest({
    int? paperType,
    String? deadline,
    String? homeworkName,
    bool? isCreatePaper,
    List<ClassInfos>? schoolClassInfos,
    List<num>? journalCatalogueIds,
    String? journalId,
    String? paperId,
    String? historyOperationId,
    String? schoolClassInfoDesc,
    String? questionDesc,
    String? journalDesc,
    String? examDesc,
    String? historyHomeworkDesc,
  }) {
    state.assignHomeworkRequest = state.assignHomeworkRequest.copyWith(
        name: homeworkName,
        paperType: paperType,
        classInfos: schoolClassInfos,
        isCreatePaper: isCreatePaper,
        journalCatalogueIds: journalCatalogueIds,
        journalId: journalId,
        paperId: paperId,
        deadline: deadline,
        historyOperationId: historyOperationId);
    state.schoolClassInfoDesc =
        schoolClassInfoDesc ?? state.schoolClassInfoDesc;
    state.questionDesc = questionDesc ?? state.questionDesc;
    state.journalDesc = journalDesc ?? state.journalDesc;
    state.examDesc = examDesc ?? state.examDesc;
    state.historyHomeworkDesc =
        historyHomeworkDesc ?? state.historyHomeworkDesc;
    update([GetBuilderIds.getUpdateAssignHomeworkRequest]);
  }

  void toReleaseWork() async {
    if ((state.assignHomeworkRequest.name?? "").isEmpty) {
      Util.toast('请填写作业名称');
      return;
    }
    // TODO 测试完毕 需打开下面内容
    if(state.assignHomeworkRequest.classInfos==null||state.assignHomeworkRequest.classInfos!.length<=0){
      Util.toast('学生选择不能为空');
      return;
    }
    if((state.assignHomeworkRequest.deadline?? "").isEmpty){
      Util.toast('作业截止日期不能为空');
      return;
    }

    if((state.assignHomeworkRequest.paperType?? 0)<=0){
      Util.toast('请选择习题、期刊、试卷库、历史作业中的一种类型布置作业');
      return;
    }
    if((state.assignHomeworkRequest.classInfos?? []).isEmpty){
      Util.toast('请选择学生布置作业');
      return;
    }
    num teacherId = SpUtil.getInt(BaseConstant.USER_ID);
    if (teacherId <= 0) {
      Util.toast('用户Id获取为空，请重新登录');
      return;
    }

    String name = state.assignHomeworkRequest.name ?? '';
    String deadline = state.assignHomeworkRequest.deadline ?? "";

    String schoolClassId =
        state.assignHomeworkRequest.classInfos![0].schoolClassId!;
    List<num> studentUserIds =
        state.assignHomeworkRequest.classInfos![0].studentUserIds!;
    ClassInfos info = ClassInfos(
        schoolClassId: schoolClassId, studentUserIds: studentUserIds);

    List<ClassInfos> classInfos = [info];
    num paperType = state.assignHomeworkRequest.paperType!;
    bool isCreatePaper =false;
    List<num> journalCatalogueIds = [];
    String journalId = '';
    String paperId = '';
    String historyOperationId = '';

    if (paperType == common.PaperType.Questions) {
      journalCatalogueIds = state.assignHomeworkRequest.journalCatalogueIds!;
    }
    if (paperType == common.PaperType.Journals) {
      journalId = state.assignHomeworkRequest.journalId!;
    }
    if (state.assignHomeworkRequest.isCreatePaper!=null) {
      isCreatePaper = state.assignHomeworkRequest.isCreatePaper!;
    }
    if (paperType == common.PaperType.exam) {
      paperId = state.assignHomeworkRequest.paperId!;
    }
    if (paperType == common.PaperType.HistoryHomework) {
      historyOperationId = state.assignHomeworkRequest.historyOperationId!;
    }

    state.assignHomeworkRequest = state.assignHomeworkRequest.copyWith(
        name: name,
        teacherId: "$teacherId",
        deadline: deadline,
        classInfos: classInfos,
        paperType: paperType,
        isCreatePaper: isCreatePaper,
        journalCatalogueIds: journalCatalogueIds,
        journalId: journalId,
        paperId: paperId,
        historyOperationId: historyOperationId);

    CommonResponse list =
        await netTool.toReleaseWork(state.assignHomeworkRequest.toJson());
    state.releaseWork = list!;
    update([GetBuilderIds.getToReleaseWork]);
  }
}
