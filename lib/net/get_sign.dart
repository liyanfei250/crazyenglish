import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../config.dart';
class GetSign{
  static String getSign(Map<String, String?> paramMap){
    return _generateMd5(_generateNormalizedString(paramMap));
  }
  static String listToString(List<String> paramList){

    if(paramList.length<1){
      return '';
    }else if(paramList.length==1){
      return paramList.removeLast();
    }else{
      var params = StringBuffer();
      String last=paramList.removeLast();
      paramList.forEach((element) {
        params.write(element+',');
      });
      params.write(last);
      print('---->'+params.toString());
      return params.toString();
    }
  }
  static String _generateMd5(String data) {
    var bytes = utf8.encode(data); // data being hashed
    var digest = md5.convert(bytes);
    return digest.toString();
  }
  static String _generateNormalizedString(Map<String, String?> paramMap) {
    var list = paramMap.keys.toList();
    list.sort();
    var buffer = StringBuffer('');
    for (var i = 0; i < paramMap.length; i++) {
      buffer.write(list[i]);
      buffer.write('=');
      buffer.write(_getLess50Str(paramMap[list[i]] ?? ""));
    }
    return buffer.toString()+Config.security_KEY;
  }
  static String _getLess50Str(String? str) {
    if(str!=null){
      if(str.length>50){
        return str.substring(0,50);
      }else{
        return str;
      }
    }else{
      return '';
    }

  }
}
