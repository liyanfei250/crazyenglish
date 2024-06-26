import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crazyenglish/routes/routes_utils.dart';
import 'package:crypto/crypto.dart';

import 'package:crazyenglish/base/common.dart';
import 'package:crazyenglish/config.dart';
import 'package:crazyenglish/net/get_sign.dart';
import 'package:crazyenglish/utils/sp_util.dart';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

import '../base/AppUtil.dart';
import '../entity/base_resp.dart';
import '../routes/app_pages.dart';

class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

class ResponseCode {
  static const int status_success = 0;
  static const int status_send_code_countdown = 9772; //倒计时时间
  static const int status_send_code_error = 9724; //验证码超时
  static const int status_sys_error = -1; //验证码超时
  static const int status_token_invalid = 40003; //token失效，张勇接口
  static const int status_token_invalid_new = 401; //token失效，胡接口
}

class NetManager {
  static Map<String, String>? headers;
  late Dio _dio;

  /// 是否是debug模式.
  static bool _isDebug = true;

  BaseOptions _options = getDefOptions();
  static NetManager? _instance;

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String _codeKey = "code";

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String _msgKey = "message";

  /// BaseResp [T data]字段 key, 默认：data.
  String _dataKey = "obj";

  static NetManager? getInstance() {
    if (_instance == null) {
      _instance = NetManager();
    }
    return _instance;
  }

  /// 打开debug模式.
  static void openDebug() {
    _isDebug = true;
  }

  void setHeaders(Map<String, dynamic> map) {
    _options.headers.remove("Authorization");
    _options.headers.addAll(map);
  }

  NetManager() {
    _dio = Dio(_options);
    //   ..httpClientAdapter = Http2Adapter(
    //   ConnectionManager(
    //     idleTimeout: 10000,
    //     // Ignore bad certificate
    //     onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
    //   ),
    // );
    if (!(Platform.isAndroid || Platform.isIOS)) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // client.findProxy = (uri) {
        //   // return "PROXY 10.155.33.120:8888";
        //   return "PROXY 10.155.43.66:8888";
        //   // return "PROXY 172.20.10.12:8886";
        //   // return "PROXY 10.155.33.120:8888";
        // };

        //下面是代理地址，需要的自己打开注释改成自己的代理
        client.findProxy = (uri) {
          return "PROXY localhost:8886;DIRECT;";
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return true;
        };
      };
    }
  }

  static BaseOptions getDefOptions() {
    // BaseOptions options = new BaseOptions();
    // options.contentType = ContentType.parse("application/json").toString();
    // options.connectTimeout = 1000 * 5;
    // options.receiveTimeout = 1000 * 10;
    return BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
      sendTimeout: 60 * 1000,
      method: Method.post,
      contentType:
      ContentType.parse("application/x-www-form-urlencoded").toString(),
    );
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options(method: method);
    }else{
      if((options!.contentType??"").isEmpty){
        options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();
      }
    }
    return options;
  }

  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseResp<T> 返回 status code msg data .
  /// BaseResp obj类型为T, 设置过去
  Future<Map> request(String method, String path,
      {data, Options? options, CancelToken? cancelToken}) async {
    if (data is Map) {
    }
    Response response;
    try {
      if (method == Method.get) {
        response = await _dio.get(path,
            options: _checkOptions(method, options),
            queryParameters: data, cancelToken: cancelToken);
      } else {
        response = await _dio.request(path,
            data: data,
            options: _checkOptions(method, options),
            cancelToken: cancelToken);
      }
    } catch (e) {

      if (e is DioError) {
          if (e.response!=null) {
            if(e.response!.data is Map){
              if(e.response!.data.containsKey("code")
                  && (e.response!.data["code"] == 40401 || e.response!.data["code"] == ResponseCode.status_token_invalid)){
                RouterUtil.toNamed(AppRoutes.LoginNew);
                Util.toast("${e.response!.data["message"]}");
                return e.response!.data;
              }else if(e.response!.data.containsKey("status")){
                if(SpUtil.getBool(BaseConstant.FIERST_NET_ERROR)){
                  Util.toast("网络错误：status: ${e.response!.data["status"]}");
                }else{
                  SpUtil.putBool(BaseConstant.FIERST_NET_ERROR,true);
                }

              }else{
                if(SpUtil.getBool(BaseConstant.FIERST_NET_ERROR)){
                  Util.toast("网络错误");
                }else{
                  SpUtil.putBool(BaseConstant.FIERST_NET_ERROR,true);
                }
              }
            }else{
              Map<String, dynamic> _dataMap = _decodeData(e.response!)!;
              if(_dataMap.containsKey("code")
                  && (_dataMap["code"] == 40401 || _dataMap["code"] == ResponseCode.status_token_invalid)){
                RouterUtil.toNamed(AppRoutes.LoginNew);
                Util.toast("${_dataMap["message"]}");
              }
              return _dataMap;
            }

          } else {
            if(SpUtil.getBool(BaseConstant.FIERST_NET_ERROR)){
              Util.toast("网络异常 dioerror：${e.message}");
            }else{
              SpUtil.putBool(BaseConstant.FIERST_NET_ERROR,true);
            }
          }
      } else {
        if(SpUtil.getBool(BaseConstant.FIERST_NET_ERROR)){
          Util.toast("网络错误");
        }else{
          SpUtil.putBool(BaseConstant.FIERST_NET_ERROR,true);
        }
      }
      return new Future.error(e);
    }

    _printHttpLog(response);
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {

          return response.data;

        } else {
          Map<String, dynamic> _dataMap = _decodeData(response)!;
          // _code = (_dataMap[_codeKey] is String)
          //     ? int.tryParse(_dataMap[_codeKey])
          //     : _dataMap[_codeKey];
          // _msg = _dataMap[_msgKey];
          // _data = _dataMap[_dataKey];
          if(_dataMap.containsKey("code")
              && (_dataMap["code"] == 40401 || _dataMap["code"] == ResponseCode.status_token_invalid)){
            RouterUtil.toNamed(AppRoutes.LoginNew);
            Util.toast("登录信息过期");
          }
          return _dataMap;
        }
      } catch (e) {
        // Util.toast("网络异常 httpCode" +
        //     response.statusCode.toString() +
        //     "\n" +
        //     response.statusMessage);
        if(SpUtil.getBool(BaseConstant.FIERST_NET_ERROR)){
          Util.toast("网络错误");
        }else{
          SpUtil.putBool(BaseConstant.FIERST_NET_ERROR,true);
        }
        return new Future.error(new DioError(
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.response, requestOptions: RequestOptions(path: ''),
        ));
      }
    } else {
      if(SpUtil.getBool(BaseConstant.FIERST_NET_ERROR)){
        Util.toast("网络错误");
      }else{
        SpUtil.putBool(BaseConstant.FIERST_NET_ERROR,true);
      }
    }
    return new Future.error(new DioError(
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.response, requestOptions: RequestOptions(path: ''),
    ));
  }

  // Future<BaseResp> request(String method, String path,
  //     {data, Options? options, CancelToken? cancelToken}) async {
  //   if (data is Map) {
  //     // if (ObjectUtil.isNotEmpty(SpUtil.getString(BaseConstant.userId))) {
  //     //   data['user_id'] = SpUtil.getString(BaseConstant.userId);
  //     // }
  //     // data['app_id'] = Config.appId;
  //     // data.remove("sign");
  //     // String params = GetSign.getSign(data as Map<String, String?>);
  //     // data['sign'] = params;
  //   }
  //   Response response;
  //   try {
  //     if (method == Method.get) {
  //       response = await _dio.get(path,
  //           options: _checkOptions(method, options),
  //           queryParameters: data, cancelToken: cancelToken);
  //     } else {
  //       response = await _dio.request(path,
  //           data: data,
  //           options: _checkOptions(method, options),
  //           cancelToken: cancelToken);
  //     }
  //   } catch (e) {
  //     if (e is DioError && e.response != null) {
  //       response = e!.response!;
  //       // Util.toastLong("网络异常 type:" +
  //       //     e.type.toString() +
  //       //     "\n" +
  //       //     e.message +
  //       //     "\n" +
  //       //     (e.response != null
  //       //         ? e.response.statusCode.toString()
  //       //         : "response 为null"));
  //     } else {
  //       Util.toastLong("网络异常");
  //       return new Future.error(e);
  //     }
  //   }
  //
  //   _printHttpLog(response);
  //   if (response.statusCode == HttpStatus.ok ||
  //       response.statusCode == HttpStatus.created) {
  //     try {
  //       // Map<String, dynamic> _dataMap = _decodeData(response)!;
  //       BaseResp baseResp = BaseResp.fromJson(response.data);
  //
  //       if (baseResp.code == HttpStatus.unauthorized) {
  //         Util.toastLong("登录信息已失效，请重新登录");
  //         SpUtil.putString(BaseConstant.loginTOKEN, "");
  //         Util.getHeader();
  //         RouterUtil.offAndToNamed(AppRoutes.LoginNew);
  //       } else if(baseResp.code == HTTP_CODE.ERROR){
  //         Util.toastLong(baseResp.message??"服务出现问题");
  //       }
  //
  //       baseResp.setReturnData(response.data);
  //       return baseResp;
  //
  //     } catch (e) {
  //       Util.toast("网络异常");
  //       return new Future.error(new DioError(
  //         response: response,
  //         error: "data parsing exception...",
  //         type: DioErrorType.response,
  //         requestOptions: RequestOptions(path: ''),
  //       ));
  //     }
  //   } else if (response.statusCode == HttpStatus.unauthorized ||
  //       (response.data != null &&
  //           response.data['code'] != null &&
  //           //response.data['code'] == ResponseCode.status_token_invalid &&
  //           response.data['code'] == ResponseCode.status_token_invalid_new)) {
  //     Util.toastLong("登录信息已失效，请重新登录");
  //     SpUtil.putString(BaseConstant.loginTOKEN, "");
  //     Util.getHeader();
  //     RouterUtil.offAndToNamed(AppRoutes.LoginNew);
  //   } else {
  //     // Util.toast("网络异常 httpCode" +
  //     //     response.statusCode.toString() +
  //     //     "\n" +
  //     //     response.statusMessage);
  //     Util.toast("网络异常");
  //   }
  //   return new Future.error(new DioError(
  //     response: response,
  //     error: "statusCode: $response.statusCode, service error",
  //     type: DioErrorType.response,
  //     requestOptions: RequestOptions(path: ''),
  //   ));
  // }


  //上传文件
  // Future<BaseResp> uploadFile<T>(
  //     String url, XFile file, Map<String, String> data) async {
  //   var bytes = await file.readAsBytes();
  //   String hash = sha256.convert(bytes).toString();
  //   //第一步组装上传图片所需url
  //   String sid = SpUtil.getString(BaseConstant.Sid);
  //   String appId = Config.appId;
  //   data.addAll({
  //     "shaCode": hash,
  //     "app_id": appId,
  //     "sid": sid,
  //   });
  //   data.remove("sign");
  //   String sign = GetSign.getSign(data);
  //   MultipartFile multipartFile =
  //       await MultipartFile.fromFile(file.path, filename: file.name);
  //   FormData formData = FormData.fromMap({"file": multipartFile});
  //   Response response;
  //   try {
  //     response = await _dio.request(url,
  //         data: formData,
  //         queryParameters: {
  //           "shaCode": hash,
  //           "app_id": appId,
  //           "sign": sign,
  //           "sid": sid,
  //         },
  //         options: new Options(
  //             method: Method.post, contentType: "multipart/form-data"),
  //         onSendProgress: (int progress, int total) {
  //       print("上传进度 $progress 总量 $total");
  //     });
  //   } catch (e) {
  //     return new BaseResp(-1, "上传失败" + e.toString());
  //   }
  //   _printHttpLog(response);
  //   String _status;
  //   int? _code;
  //   String? _msg;
  //   T? _data;
  //   if (response.statusCode == HttpStatus.ok ||
  //       response.statusCode == HttpStatus.created) {
  //     try {
  //       return BaseResp.fromJson(json);
  //     } catch (e) {
  //       // Util.toast("网络异常 httpCode" +
  //       //     response.statusCode.toString() +
  //       //     "\n" +
  //       //     response.statusMessage);
  //       Util.toast("网络异常");
  //       return new Future.error(new DioError(
  //           response: response,
  //           error: "data parsing exception...",
  //           type: DioErrorType.response,
  //           requestOptions: RequestOptions(path: '')));
  //     }
  //   } else {
  //     // Util.toast("网络异常 httpCode" +
  //     //     response.statusCode.toString() +
  //     //     "\n" +
  //     //     response.statusMessage);
  //     Util.toast("网络异常");
  //   }
  //
  //   return new Future.error(new DioError(
  //       response: response,
  //       error: "statusCode: $response.statusCode, service error",
  //       type: DioErrorType.response,
  //       requestOptions: RequestOptions(path: '')));
  // }
  //
  // //上传图片
  // Future<BaseResp> upLoadImage(
  //     String url, XFile image, Map<String, String> data) async {
  //   //拼装body体所需要的
  //   String BOUNDARY = "------------------319831265358979362846";
  //   String lineEnd = "\r\n";
  //   String twoHyphens = "--";
  //   //第一步组装上传图片所需url
  //   String sid = SpUtil.getString(BaseConstant.Sid);
  //   String appId = Config.appId;
  //   data.addAll({"app_id": appId, "sid": sid});
  //   String sign = GetSign.getSign(data);
  //   //第二步从文件中获得文件名字
  //   String path = image.path;
  //   var name = path.substring(path.lastIndexOf("/") + 1, path.length);
  //
  //   String firstLine = twoHyphens + BOUNDARY + lineEnd;
  //   String secondLine =
  //       "Content-Disposition: form-data; name=\"image,jpeg\";filename=\"" +
  //           "image.jpeg" +
  //           "\"" +
  //           lineEnd;
  //   String thirdLine = "Content-Type: " + "image/jpeg" + lineEnd;
  //   String forthLine = lineEnd;
  //
  //   Uint8List bytes;
  //   ImageProperties properties =
  //       await FlutterNativeImage.getImageProperties(image.path);
  //   if (properties.width! > 500 && properties.height! > 500) {
  //     var originX = (properties.width! - 500) / 2;
  //     var originY = (properties.height! - 500) / 2;
  //     File croppedFile = await FlutterNativeImage.cropImage(
  //         image.path, originX.toInt(), originY.toInt(), 500, 500);
  //     File compressedFile = await FlutterNativeImage.compressImage(
  //         croppedFile.path,
  //         quality: 50,
  //         percentage: 50);
  //     bytes = await File(compressedFile.path).readAsBytesSync();
  //   } else {
  //     bytes = await File(image.path).readAsBytesSync();
  //   }
  //
  //   if (bytes == null) {
  //     return BaseResp(-1, "操作失败");
  //   }
  //
  //   // ImageProperties properties = await FlutterNativeImage.getImageProperties(image.path);
  //   // File compressedFile = await FlutterNativeImage.compressImage(image.path, quality: 50,
  //   //     targetWidth: 80,
  //   //     targetHeight: (properties.height * 80 / properties.width).round());
  //
  //   // File compressedFile = await FlutterNativeImage.compressImage(file.path,
  //   //     quality: quality, percentage: percentage);
  //
  //   String sixthLine = lineEnd;
  //   String seventhLine = twoHyphens + BOUNDARY + twoHyphens + lineEnd;
  //
  //   List<int> preList =
  //       utf8.encode(firstLine + secondLine + thirdLine + forthLine);
  //   Uint8List pre = Uint8List.fromList(preList);
  //
  //   List<int> endList = utf8.encode(sixthLine + seventhLine);
  //   Uint8List end = Uint8List.fromList(endList);
  //
  //   Uint8List allContent = Uint8List.fromList(pre + bytes + end);
  //   dynamic response = null;
  //   try {
  //     response = await _dio.post<String>(url,
  //         data: Stream.fromIterable(allContent.map((e) => [e])),
  //         queryParameters: {"app_id": appId, "sid": sid, "sign": sign},
  //         options: Options(sendTimeout: 60 * 1000,
  //             // contentType:
  //             //     "multipart/form-data;boundary=------------------319831265358979362846",
  //             headers: {
  //               "Connection": "Keep-Alive",
  //               "Content-Type":
  //                   "multipart/form-data;boundary=------------------319831265358979362846"
  //             }));
  //   } catch (e) {
  //     return new BaseResp(-1, "上传失败" + e.toString());
  //   }
  //   int? _code;
  //   String? _msg;
  //   if (response.statusCode == HttpStatus.ok ||
  //       response.statusCode == HttpStatus.created) {
  //     try {
  //       Map<String, dynamic> _dataMap = _decodeData(response)!;
  //       _code = (_dataMap[_codeKey] is String)
  //           ? int.tryParse(_dataMap[_codeKey])
  //           : _dataMap[_codeKey];
  //       _msg = _dataMap[_msgKey];
  //       // if(_code == C.SID_INVALID){
  //       //   // eventBus.fire(ChangeThemeEvent(Random().nextInt(7)));
  //       // }else{
  //       return new BaseResp(_code, _msg);
  //       // }
  //     } catch (e) {
  //       return new BaseResp(
  //           -1,
  //           "网络异常 httpCode" +
  //               response.statusCode.toString() +
  //               "\n" +
  //               response.statusMessage);
  //     }
  //   } else {
  //     return new BaseResp(
  //         -1,
  //         "网络异常 httpCode" +
  //             response.statusCode.toString() +
  //             "\n" +
  //             response.statusMessage);
  //   }
  // }

  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// <BaseRespR<T> 返回 status code msg data  Response.
  Future<BaseRespR<T?>> requestR<T>(String method, String path,
      {data, Options? options, CancelToken? cancelToken}) async {
    Response response =
        await _dio.request(path, data: data, cancelToken: cancelToken);
    _printHttpLog(response);
    String? _status;
    int? _code;
    String? _msg;
    T? _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else if (response.data is String) {
          _code = (response.data[_codeKey] is String)
              ? int.tryParse(response.data[_codeKey])
              : response.data[_codeKey];
          _msg = response.data[_msgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response)!;
          _code = (_dataMap[_codeKey] is String)
              ? int.tryParse(_dataMap[_codeKey])
              : _dataMap[_codeKey];
          _msg = _dataMap[_msgKey];
          _data = _dataMap[_dataKey];
        }
        return new BaseRespR(_status, _code, _msg, _data, response);
      } catch (e) {
        return new Future.error(new DioError(
            response: response,
            error: "data parsing exception...",
            type: DioErrorType.response,
            requestOptions: RequestOptions(path: '')));
      }
    }
    return new Future.error(new DioError(
        response: response,
        error: "statusCode: $response.statusCode, service error",
        type: DioErrorType.response,
        requestOptions: RequestOptions(path: '')));
  }

  /// decode response data.
  Map<String, dynamic>? _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

  /// print Http Log.
  void _printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      print("----------------Http Log----------------" +
          "\n[statusCode]:   " +
          response.statusCode.toString() +
          "\n[request   ]:   " +
          _getOptionsStr(response.requestOptions));
      _printDataStr("reqdata ", response.requestOptions.data);
      _printDataStr("reqdata HEADER ", response.requestOptions.headers['Authorization']);
      _printDataStr("response", response.data);
    } catch (ex) {
      print("Http Log" + " error......");
    }
  }

  /// get Options Str.
  String _getOptionsStr(RequestOptions request) {
    return "method: " +
        request.method +
        "  baseUrl: " +
        request.baseUrl +
        "  path: " +
        request.path;
  }
  /// get Options Str.
  String _getOptionsBody(RequestOptions request) {
    return "body: " +
        request.data ;
  }

  /// print Data Str.
  void _printDataStr(String tag, Object? value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   " + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   " + da);
        da = "";
      }
    }
  }

  get(String url, Function callBack) async {
    int? code;
    try {
      Response response;
      response = await _dio.get(url);
      code = response.statusCode;
      if (code != 200) {
        callBack('请求出错:系统异常' + code.toString());
        return;
      }
      String dataStr = json.encode(response.data);
      Map? dataMap = json.decode(dataStr);
      callBack(dataMap);
    } on DioError catch (exception) {
      callBack('请求出错:网络异常' + exception.toString());
    }
  }

  getRequestMap(Function callBack, {Map<String, String>? requestMaps}) async {
    if (requestMaps == null) {
      requestMaps = new Map<String, String>();
    }
    requestMaps['app_id'] = Config.appId;
    requestMaps.remove("sign");
    String params = GetSign.getSign(requestMaps);
    requestMaps['sign'] = params;
    callBack(requestMaps);
    // await ChannelManger.getInstance()
    //     .channel
    //     .invokeMethod("getRequestMap", {'map': requestMaps}).then((result) {
    //   Map<String, String> requestParamsMaps =
    //       new Map<String, String>.from(result);
    //   callBack(requestParamsMaps);
    // });
  }
}
