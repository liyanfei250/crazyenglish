import '../../../entity/assign_homework_request.dart';
import '../../../entity/common_response.dart';

class AssignHomeworkState {
  CommonResponse releaseWork = CommonResponse();
  AssignHomeworkRequest assignHomeworkRequest = AssignHomeworkRequest();
  String schoolClassInfoDesc = "";
  String questionDesc = "";
  String journalDesc = "";
  String examDesc = "";
  String historyHomeworkDesc = "";
  AssignHomeworkState() {
    ///Initialize variables
  }
}
