import '../../../entity/review/HomeSecondListDate.dart';
import '../../../entity/start_exam.dart';
import '../../../entity/week_detail_response.dart';

class WeekTestDetailState {
  WeekDetailResponse weekDetailResponse = WeekDetailResponse();
  StartExam startExam = StartExam();

  String uuid = "";
  bool enterResult = false;
  bool isOffCurrentPage = false;
  int parentIndex = 0;
  int childIndex = 0;
  String operationStudentId ="";
  String operationId ="";

  JouralResultResponse jouralResultResponse = JouralResultResponse();
  List<CatalogueRecordVoList> catalogueRecordVoList = [];

  WeekTestDetailState() {
    ///Initialize variables
  }
}
