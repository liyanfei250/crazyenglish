import 'dart:convert';
import 'dart:io';

import 'package:crazyenglish/entity/week_directory_response.dart';
import 'package:crazyenglish/entity/week_list_response.dart' as weekTest;
import 'package:dio/dio.dart';

import '../api/api.dart';
import '../base/AppUtil.dart';
import '../entity/base_resp.dart';
import '../entity/check_update_resp.dart';
import '../entity/commit_request.dart';
import '../entity/review/HomeWeeklyChoiceDate.dart';
import '../entity/start_exam.dart';
import '../entity/user_info_response.dart';
import '../entity/week_detail_response.dart' as weekDetail;
import '../net/net_manager.dart';

/**
 * Time: 2022/12/22 14:56
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

class WeekTestRepository{

  Future<weekTest.Data> getWeekTestList(Map<String,String> req) async{
    String testData = "{\"code\":1,\"data\":{\"count\":2,\"rows\":[{\"uuid\":\"1cdd1550-bcef-11ed-8e11-530450f105f5\",\"name\":\"测试全部题型用\",\"img\":\"https://test-1315843937.cos.ap-beijing.myqcloud.com/1aba8370-bcef-11ed-8e11-530450f105f5tiancaia1.jpg\",\"weekTime\":\"2023-03-05T16:00:00.000Z\",\"see\":0},{\"uuid\":\"6b01ee40-be16-11ed-abb8-4bd615e260c3\",\"name\":\"七年级新目标\",\"img\":\"https://test-1315843937.cos.ap-beijing.myqcloud.com/53fe3500-be16-11ed-abb8-4bd615e260c3tiancai483f30cbf856f2868f89ce5bca0dc58.png\",\"weekTime\":\"2023-02-28T16:00:00.000Z\",\"see\":0}]},\"msg\":\"\"}";

    if(Util.isTestMode()){
      weekTest.WeekListResponse weekTestListResponse = weekTest.WeekListResponse.fromJson(json.decode(testData));
      return weekTestListResponse.data!;
    }

    Map baseResp = await NetManager.getInstance()!
        .request(Method.get, Api.getWeeklyList,
        data: req,options: Options(method: Method.get));

    if(baseResp !=null){
      weekTest.WeekListResponse weekTestListResponse = weekTest.WeekListResponse.fromJson(baseResp);
      if (weekTestListResponse.code != ResponseCode.status_success) {
        return Future.error(weekTestListResponse.message!);
      }
      return weekTestListResponse.data!;
    } else {
      return Future.error("返回weekTestListResponse为空");
    }

  }


  Future<WeekDirectoryResponse> getWeekTestCategory(String periodicaId) async{
    String testData = "{\"code\":1,\"data\":[{\"uuid\":\"6b028a80-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一部分听力（共两节， 满分 30 分 ）\",\"sort\":267,\"parentId\":\"6b01ee40-be16-11ed-abb8-4bd615e260c3\",\"childList\":[{\"uuid\":\"6b028a81-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节 （共5小题；每小题1.5分，满分7.5分）\",\"sort\":268,\"parentId\":\"6b028a80-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b190-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二节 （共15小题；每小题1.5分，满分22.5分）\",\"sort\":269,\"parentId\":\"6b028a80-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]}]},{\"uuid\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二部分阅读理解（共两节，满分40分）\",\"sort\":270,\"parentId\":\"6b01ee40-be16-11ed-abb8-4bd615e260c3\",\"childList\":[{\"uuid\":\"6b02b192-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节A篇 （共3小题；每小题2分，满分6分）\",\"sort\":271,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b193-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节B篇 （共4小题；每小题2分，满分8分）\",\"sort\":272,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b194-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节C篇 （共4小题；每小题2分，满分8分）\",\"sort\":273,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b195-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节D篇 （共4小题；每小题2分，满分8分）\",\"sort\":274,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b196-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二节 （共5小题；每小题2分，满分10分）\",\"sort\":275,\"parentId\":\"6b02b191-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]}]},{\"uuid\":\"6b02b197-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第三部分语言知识运用（共两节，满分45 分）\",\"sort\":276,\"parentId\":\"6b01ee40-be16-11ed-abb8-4bd615e260c3\",\"childList\":[{\"uuid\":\"6b02b198-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节 （共20小题；每小题1.5分，满分30分）\",\"sort\":277,\"parentId\":\"6b02b197-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02b199-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二节 （共10小题；每小题1.5分，满分15分）\",\"sort\":278,\"parentId\":\"6b02b197-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]}]},{\"uuid\":\"6b02b19a-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第四部分写作（共两节，满分35分）\",\"sort\":279,\"parentId\":\"6b01ee40-be16-11ed-abb8-4bd615e260c3\",\"childList\":[{\"uuid\":\"6b02b19b-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第一节 短文改错 （共10小题；每小题1分，满分10分）\",\"sort\":280,\"parentId\":\"6b02b19a-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]},{\"uuid\":\"6b02d8a0-be16-11ed-abb8-4bd615e260c3\",\"name\":\"第二节 书面表达 （满分25分）\",\"sort\":281,\"parentId\":\"6b02b19a-be16-11ed-abb8-4bd615e260c3\",\"childList\":[]}]}],\"msg\":\"\"}";


    if(Util.isTestMode()){
      WeekDirectoryResponse weekTestCatalogResponse = WeekDirectoryResponse.fromJson(json.decode(testData));
      return weekTestCatalogResponse!;
    }

    Map map = await NetManager.getInstance()!
        .request(data:{"uuid":periodicaId},Method.get, Api.getWeeklyDirectory,
        options: Options(method: Method.get));

    if ( map != null ) {
      WeekDirectoryResponse weekTestCatalogResponse = WeekDirectoryResponse.fromJson(map);
      if(weekTestCatalogResponse.code != ResponseCode.status_success){
        return Future.error("返回WeekDirectoryResponse为空");
      } else {
        return weekTestCatalogResponse!;
      }
    } else {
      return Future.error("返回WeekDirectoryResponse为空");
    }
  }


  Future<weekDetail.WeekDetailResponse> getWeekTestDetail(String id) async{

    String dd = "{\"code\":1,\"data\":[{\"uuid\":\"311a5c70-be6c-11ed-bb6b-155a0187eb87\",\"title\":\"请阅读下面短文,根据短文内容,从方框内所给的选项中选出能填入空白处的最佳选项,并将其答案标号写在方框下面的横线上。选项中有一项为多余顶，\",\"content\":\"<p>When you think of pollution, what comes to mind?<u>&emsp;&emsp;44&emsp;&emsp;</u> After all, theyare common in our life. However, there is another form of pollution that youdon’t cven realize. Even if you can't see this kind of pollution, you can hearit. And that's the problem! Now, you may have known what we're talkingabout. Yes. noise pollution<u>&emsp;&emsp;45&emsp;&emsp;</u></p><p>Ifyou think about it, you will find that you're usually surrounded (围统)by sounds from the time you wake up until you go to bed. Alarm clocksschool bells. people's voices, music, televisions, traffic, and the list goes onand on. We get so used to these sounds that we often give them little thoughtThey' re just part of our everyday lives. <u>&emsp;&emsp;46&emsp;&emsp;</u> When they do, we call themnoise pollution because they can have a bad influence on our life.<br/>并将<br/><u>&emsp;&emsp;47&emsp;&emsp;</u> First of all, industrial factories are filled with large machines thatcan create a lot of noise. And noise can be made in our own homes too. If youopen your ears and listen, you'll realize that all kinds of machines create noisearound you,including fans,washing machines,lawnmowers (割草机)，ancvacuum cleaners(真空吸尘器)<br/><u>&emsp;&emsp;48&emsp;&emsp;</u> Well, yes! It not only influences wildlife and the environment butalso causes stress, headaches, high blood pressure, hearing loss, or even heartproblems in people. The noise pollution has led some people to create quietplaces in parks and forests, where humans can get away from noise pollutionand enjoy the sounds of naturc, like drops of water.</p><p><br/></p><p>A. Is noise pollution a big deal?&nbsp;</p><p>B.Noise pollution has many sources(来源).</p><p>C. Can noise pollution bring us any advantages?</p><p>D. Some people may think of air pollution and water pollution.</p><p>E.However, these “ normal” sounds often cross the line andbecome unwanted.</p><p>F. It could influence you more than you imagine.</p>\",\"options\":[{\"name\":\"44\",\"value\":\"A\"},{\"name\":\"45\",\"value\":\"B\"},{\"name\":\"46\",\"value\":\"C\"},{\"name\":\"47\",\"value\":\"D\"},{\"name\":\"48\",\"value\":\"E\"}],\"answer\":[],\"type\":2,\"typeChildren\":2,\"audio\":null,\"modelessay\":null,\"mediumtext_url\":null}],\"msg\":\"\"}";
    
    if(Util.isTestMode()){
      weekDetail.WeekDetailResponse weekTestDetailResponse = weekDetail.WeekDetailResponse.fromJson(json.decode(dd));
      return weekTestDetailResponse!;
    }

    Map map = await NetManager.getInstance()!
        .request(data:{"uuid":id},Method.get, Api.getWeekDetail,
        options: Options(method: Method.get));


    if ( map != null ) {
      weekDetail.WeekDetailResponse weekTestCatalogResponse = weekDetail.WeekDetailResponse.fromJson(map);
      if(weekTestCatalogResponse.code != ResponseCode.status_success){
        return Future.error("返回WeekDirectoryResponse为空");
      } else {
        return weekTestCatalogResponse!;
      }
    } else {
      return Future.error("返回WeekDirectoryResponse为空");
    }

  }

  Future<StartExam> getStartExam(String id) async{
    Map map = await NetManager.getInstance()!
        .request(Method.get, Api.getStartExam,
        options: Options(method: Method.get));

    StartExam startExam = StartExam.fromJson(map);

    if (startExam.code != ResponseCode.status_success) {
      return Future.error(startExam.message!);
    }
    if(startExam.code ==0){
      return startExam;
    } else {
      return Future.error("返回开始作答信息为空");
    }
  }

  Future<CommitAnswer> uploadWeekTest(CommitAnswer commitRequest) async{

    if(Util.isTestMode()){
      CommitResponse commitResponse = CommitResponse(code:1,msg:"",data:CommitAnswer());
      return commitResponse.data!;
    }
    Map map = await NetManager.getInstance()!
        .request(data:commitRequest.toJson(),Method.post, Api.postWeekCommit,
        options: Options(method: Method.post,contentType: ContentType.json.toString()));
    CommitResponse commitResponse = CommitResponse.fromJson(map);
    if (commitResponse.code != ResponseCode.status_success) {
      return Future.error(commitResponse.message!);
    } else {
      return commitResponse.data!;
    }
  }

  Future<CheckUpdateResp> getAppVersion() async{
    // BaseResp baseResp = await NetManager.getInstance()!
    //     .request(Method.get, Api.getAppVersion+(Platform.isAndroid? "1":"2"),
    //     options: Options(method: Method.get));
    // if (baseResp.code != ResponseCode.status_success) {
    //   return Future.error(baseResp.message!);
    // }
    // if(baseResp.getReturnData() !=null){
    //   CheckUpdateResponse checkUpdateResp = CheckUpdateResponse.fromJson(baseResp.getReturnData());
    //   return checkUpdateResp!.data!;
    // } else {
      return Future.error("返回CheckUpdateResp为空");
    // }
  }

  Future<HomeWeeklyChoiceDate> getHomeWeeklyChoiceDate(
      String id) async {
    Map map = await NetManager.getInstance()!.request(
        Method.get, Api.getHomeWeeklyChoiceDate,
        options: Options(method: Method.get));
    HomeWeeklyChoiceDate paperDetail = HomeWeeklyChoiceDate.fromJson(map);
    if (paperDetail.code != ResponseCode.status_success) {
      return Future.error(paperDetail.message!);
    } else {
      return paperDetail!;
    }
  }
}