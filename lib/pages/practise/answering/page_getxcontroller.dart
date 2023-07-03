import 'package:get/get.dart';

import '../../../routes/getx_ids.dart';

/**
 * Time: 2023/4/26 15:41
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class PageGetxController extends GetxController{
  void nextPage(){
    print("PageGetxController call next Page");
    update([GetBuilderIds.answerNextPage]);
  }

  void prePage(){
    update([GetBuilderIds.answerPrePage]);
  }
}