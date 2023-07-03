import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/entity/SendCodeResponseNew.dart';
import 'package:crazyenglish/entity/home/HomeKingDate.dart';
import 'package:crazyenglish/entity/update_userinfo_request.dart';
import 'package:crazyenglish/entity/user_info_response.dart';
import 'package:crazyenglish/net/net_manager.dart';
import 'package:crazyenglish/repository/other_repository.dart';
import 'package:crazyenglish/repository/user_repository.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:get/get.dart';

import '../../../entity/home/CommentDate.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/json_cache_util.dart';
import 'person_info_state.dart';

class Person_infoLogic extends GetxController {
  final Person_infoState state = Person_infoState();
  UserRepository recordData = UserRepository();
  OtherRepository otherRepository = OtherRepository();

  void getPersonInfo(String id, {bool needCheckLogin = false}) async {
    if (needCheckLogin && !SpUtil.getBool(BaseConstant.ISLOGING)) {
      return;
    }
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.PersonInfo,
            labelId: id)
        .then((value) {
      if (value != null) {
        return UserInfoResponse.fromJson(value as Map<String, dynamic>?);
      }
    });

    if (cache is UserInfoResponse) {
      state.infoResponse = cache!;
      update([GetBuilderIds.getPersonInfo]);
    }
    UserInfoResponse list = await recordData.getUserInfo();
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.PersonInfo, labelId: id, list.toJson());
    state.infoResponse = list!;
    update([GetBuilderIds.getPersonInfo]);
  }

  void updateNativeUserInfo(UserInfoResponse? infoResponse) {
    if (infoResponse != null) {
      SpUtil.putInt(BaseConstant.USER_ID, infoResponse.obj!.id!.toInt());
      SpUtil.putString(BaseConstant.USER_NAME, "${infoResponse.obj!.username}");
      SpUtil.putString(BaseConstant.NICK_NAME, "${infoResponse.obj!.nickname}");
      SpUtil.putBool(BaseConstant.ISLOGING, true);
      SpUtil.putObject(BaseConstant.USER_INFO, infoResponse);
    }
  }

  void getChoiceMap(String dictionaryType) async {
    var cache = await JsonCacheManageUtils.getCacheData(
            JsonCacheManageUtils.HomeListChoiceDate,
            labelId: dictionaryType.toString())
        .then((value) {
      if (value != null) {
        return HomeKingDate.fromJson(value as Map<String, dynamic>?);
      }
    });

    bool hasCache = false;
    if (cache is HomeKingDate) {
      state.homeKingDate = cache!;
      hasCache = true;
      update([GetBuilderIds.getHomeListChoiceDate]);
    }
    HomeKingDate list =
        await otherRepository.getDictionaryDataByType(dictionaryType);
    JsonCacheManageUtils.saveCacheData(
        JsonCacheManageUtils.HomeListChoiceDate,
        labelId: dictionaryType,
        list.toJson());
    state.homeKingDate = list!;
    if (!hasCache) {
      update([GetBuilderIds.getHomeListChoiceDate]);
    }
  }

  void changeNickName(String nickname) async {
    UpdateUserinfoRequest updateUserinfoRequest =
        UpdateUserinfoRequest(nickname: nickname);
    CommentDate collectResponse =
        await recordData.toChangePersonInfo(updateUserinfoRequest.toJson());
    state.pushDate = collectResponse;
    if (collectResponse.code == ResponseCode.status_success) {
      update([GetBuilderIds.toChangeNickName]);
    }
  }

  void toChangePhoneNum(String phone) async {
    UpdateUserinfoRequest updateUserinfoRequest =
        UpdateUserinfoRequest(phone: phone);
    CommentDate collectResponse =
        await recordData.toChangePersonInfo(updateUserinfoRequest.toJson());
    state.pushDate = collectResponse;
    if (collectResponse.code == ResponseCode.status_success) {
      update([GetBuilderIds.toChangePhoneNumber]);
    }
  }

  void sendCode(String phone, int type) async {
    SendCodeResponseNew sendCodeResponse =
        await recordData.sendCodeNew(phone, "$type");
    state.sendCodeResponse = sendCodeResponse;
    update([GetBuilderIds.sendCode]);
  }

  void toChangeGrade(List<num> affiliatedGrade) async {
    UpdateUserinfoRequest updateUserinfoRequest =
        UpdateUserinfoRequest(affiliatedGrade: affiliatedGrade);
    CommentDate collectResponse =
        await recordData.toChangePersonInfo(updateUserinfoRequest.toJson());
    state.pushDate = collectResponse;
    if (collectResponse.code == ResponseCode.status_success) {
      update([GetBuilderIds.toAffiliatedGrade]);
    }
  }

  void toChangeRole(num identity) async {
    UpdateUserinfoRequest updateUserinfoRequest =
        UpdateUserinfoRequest(identity: identity);
    CommentDate collectResponse =
        await recordData.toChangePersonInfo(updateUserinfoRequest.toJson());
    state.pushDate = collectResponse;
    if (collectResponse.code == ResponseCode.status_success) {
      update([GetBuilderIds.toChangeRole]);
    }
  }

  void toChangeHeadImg(String url) async {
    UpdateUserinfoRequest updateUserinfoRequest =
        UpdateUserinfoRequest(url: url);
    CommentDate collectResponse =
        await recordData.toChangePersonInfo(updateUserinfoRequest.toJson());
    state.pushDate = collectResponse;
    if (collectResponse.code == ResponseCode.status_success) {
      update([GetBuilderIds.toChangeHeadImg]);
    }
  }

  void toChangePassword(String oldPassword, String password) async {
    UpdateUserinfoRequest updateUserinfoRequest =
        UpdateUserinfoRequest(oldPassword: oldPassword, password: password);
    CommentDate collectResponse =
        await recordData.toChangePersonPsd(updateUserinfoRequest.toJson());
    state.pushDate = collectResponse;
    update([GetBuilderIds.toChangePassword]);
  }
}
