import 'dart:io';

import 'package:dio/dio.dart';

import '../../api/api.dart';
import '../../entity/class_list_response.dart';
import '../../net/net_manager.dart';

class ClassRepository{
  Future<ClassListResponse> getMyClassList(
      Map<String,dynamic> req) async {
    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.TeacherClassList,data: req,
        options: Options(method: Method.post,contentType: ContentType.json.toString()));
    ClassListResponse paperDetail = ClassListResponse.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
}