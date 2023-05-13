import 'dart:io';

import 'package:crazyenglish/entity/homework_request.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:dio/dio.dart';

import '../api/api.dart';
import '../base/common.dart';
import '../entity/HomeworkHistoryResponse.dart';
import '../entity/base_resp.dart';
import '../entity/homework_detail_response.dart';
import '../net/net_manager.dart';

/**
 * Time: 2023/5/13 07:37
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class HomeworkRepository{

  // 获取作业历史列表
  Future<HomeworkHistoryResponse> getHistoryHomework(int page ,int pageSize) async {

    P p = P(
      current: page,
      size: pageSize,
    );
    // TODO 替换成真实id 用户登录完毕就应该确定 是进入教师端还是学生端 不应本地单独存入是学生还是老师
    HomeworkRequest request = HomeworkRequest(
      actionType: 1,
      teacherId: "1651539603655626753",
      schoolClassId: 1655395694170124290.toString(),
      startDate: "2023-04-24",
      endDate: "2023-05-13",
      orderType: "460",
      p: p
    );

    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.historyPage,
        data: request,
        options: Options(method: Method.post,contentType: ContentType.json.toString(),));

    if (map != null) {
      HomeworkHistoryResponse homeworkHistoryResponse =
      HomeworkHistoryResponse.fromJson(map);
      if (homeworkHistoryResponse.code != ResponseCode.status_success) {
        return Future.error("返回WeekDirectoryResponse为空");
      } else {
        return homeworkHistoryResponse!;
      }
    } else {
      return Future.error("返回WeekDirectoryResponse为空");
    }
  }

  // 获取作业详情
  Future<HomeworkDetailResponse> getPreviewOperation(int paperType,int paperId) async {

    Map map = await NetManager.getInstance()!.request(
        Method.post, Api.previewOperation,
        options: Options(method: Method.post,contentType: ContentType.json.toString(),));

    if (map != null) {
      HomeworkDetailResponse homeworkDetailResponse =
      HomeworkDetailResponse.fromJson(map);
      if (homeworkDetailResponse.code != ResponseCode.status_success) {
        return Future.error("返回homeworkDetailResponse为空");
      } else {
        return homeworkDetailResponse!;
      }
    } else {
      return Future.error("返回homeworkDetailResponse为空");
    }
  }
}