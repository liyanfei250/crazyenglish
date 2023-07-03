class KoolException implements Exception {
  String? errorDescriptions;
  String message;
  KoolExceptionType exceptionType = KoolExceptionType.OTHER;

  KoolException(this.exceptionType, this.message, this.errorDescriptions);

  KoolException.noDescrip(this.exceptionType, this.message);

  @override
  String toString() {
    return 'KoolException{errorDescriptions: $errorDescriptions, message: $message, exceptionType: $exceptionType}';
  }
}

enum KoolExceptionType {
  // 超时异常 : 包括请求超时，接收超时，发送超时异常
  TIMEOUT,
  // 当请求取消时的异常,
  CANCEL,
  // 其他异常 : 未知的异常，包括断网的情况
  OTHER,
  // 服务器响应，但是响应异常，包含 500，404 ，503 等
  RESPONSE,
  // 服务器内部异常，返回成功，但code！=0
  SERVER_NEIBU,
  // 返回obj为null 或 Json转换异常
  SERVER_NODATA,
}
