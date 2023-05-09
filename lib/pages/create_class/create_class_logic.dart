import 'package:crazyenglish/entity/base_resp.dart';
import 'package:get/get.dart';

import '../../entity/common_response.dart';
import '../../routes/getx_ids.dart';
import '../../utils/json_cache_util.dart';
import '../mine/ClassRepository.dart';
import 'create_class_state.dart';

class Create_classLogic extends GetxController {
  final Create_classState state = Create_classState();
  ClassRepository netTool = ClassRepository();

  //班级添加
  void toAddClass(String image, String name, String teacherUserId) async {
    Map<String, String> req = {};
    req['image'] = image;
    req['name'] = name;
    req['teacherUserId'] = teacherUserId;
    CommonResponse list = await netTool.myClassAdd(req);
    state.myClassList = list!;
    update([GetBuilderIds.getMyClassAdd]);
  }
}
