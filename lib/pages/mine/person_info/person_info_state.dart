
import 'package:crazyenglish/entity/SendCodeResponseNew.dart';
import 'package:crazyenglish/entity/home/CommentDate.dart';
import 'package:crazyenglish/entity/home/HomeKingDate.dart';
import 'package:crazyenglish/entity/user_info_response.dart';

class Person_infoState {
  CommentDate pushDate = CommentDate();
  UserInfoResponse infoResponse = UserInfoResponse();
  HomeKingDate homeKingDate = HomeKingDate();
  SendCodeResponseNew sendCodeResponse = SendCodeResponseNew();
  Person_infoState() {
    ///Initialize variables
  }
}
