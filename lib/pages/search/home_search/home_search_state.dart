import 'package:crazyenglish/entity/home/HomeSearchListDate.dart';

class Home_searchState {
  List<Records> listJ = [];
  List<RecordsS> listS = [];
  bool hasMoreS = true;
  int pageNoS = 1;
  int currentPageNoS = 1;
  bool hasMorej = true;
  int pageNoj = 1;
  int currentPageNoj = 1;
  String searchText = '';

  //TODO 搜索类型处理
  //TODO 学生信息
  //TODO 分页处理
  //TODO 历史作业抽出来
  final int pageSize = 20;

  final int pageStartIndex = 1;
  int searchType = 1;//学生格式还是期刊格式 1：期刊 2：商城 3：学生

  Home_searchState() {
    ///Initialize variables
  }
}