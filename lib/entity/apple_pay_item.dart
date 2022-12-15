class ApplePayItem {

  String? productId;
  String? userId;
  String? desc;
  String? money;
  String? rechargeData;
  String? rechargeTime;
  String? tradeNo;
  String? thirdSign;
  String? receiptData;

  static List<ApplePayItem>? fromList(List<dynamic>? list) {
    if (list == null) return null;
    List<ApplePayItem> listData = <ApplePayItem>[];

    if(list!=null){
      list.forEach((element) {
        ApplePayItem bindInfo = ApplePayItem.fromMap(element);
        listData.add(bindInfo);
      });
    }
    return listData;
  }

  static ApplePayItem fromMap(dynamic map) {

    ApplePayItem applePayItem = ApplePayItem();
    if (map == null) return applePayItem;
    applePayItem.thirdSign = map['thirdSign'];
    applePayItem.productId = map['productId'];
    applePayItem.userId = map['userId'];
    applePayItem.desc = map['desc'];
    applePayItem.money = map['money'];
    applePayItem.rechargeData = map['rechargeData'];
    applePayItem.rechargeTime = map['rechargeTime'];
    applePayItem.tradeNo = map['tradeNo'];
    applePayItem.receiptData = map['receiptData'];
    return applePayItem;
  }

  Map<String,String> toJson() => {
    "thirdSign":thirdSign!=null ? thirdSign.toString():"",
    "productId":productId!=null? productId!:"",
    "userId":userId!=null? userId!:"",
    "desc":desc!=null? desc!:"",
    "money":money!=null? money!:"",
    "rechargeData":rechargeData!=null? rechargeData!:"",
    "rechargeTime":rechargeTime!=null? rechargeTime!:"",
    "tradeNo":tradeNo!=null? tradeNo!:"",
    "receiptData":receiptData!=null? receiptData!:"",
  };
}