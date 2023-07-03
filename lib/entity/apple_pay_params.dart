
class ApplePayParams{

  bool? recharge_status;
  String? next_url;

  static ApplePayParams? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    ApplePayParams applePayParams = ApplePayParams();
    applePayParams.recharge_status = map['recharge_status'];
    applePayParams.next_url = map['next_url'];
    return applePayParams;
  }

  Map toJson() => {
    "isSuccess": recharge_status,
    "next_url": next_url,
  };
}