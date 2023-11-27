class WithdrawRequestModel {
  bool? status;
  String? message;
  WithdrawRequestList? data;

  WithdrawRequestModel({
    this.status,
    this.message,
    this.data,
  });

  factory WithdrawRequestModel.fromJson(Map<String, dynamic> json) =>
      WithdrawRequestModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : WithdrawRequestList.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class WithdrawRequestList {
  List<RequestList>? list;
  List<String>? status;
  List<String>? statusIcon;
  List<dynamic>? payoutTransaction;

  WithdrawRequestList({
    this.list,
    this.status,
    this.statusIcon,
    this.payoutTransaction,
  });

  factory WithdrawRequestList.fromJson(Map<String, dynamic> json) =>
      WithdrawRequestList(
        list: json["list"] == null
            ? []
            : List<RequestList>.from(
                json["list"]!.map((x) => RequestList.fromJson(x))),
        status: json["status"] == null
            ? []
            : List<String>.from(json["status"]!.map((x) => x)),
        statusIcon: json["status_icon"] == null
            ? []
            : List<String>.from(json["status_icon"]!.map((x) => x)),
        payoutTransaction: json["payout_transaction"] == null
            ? []
            : List<dynamic>.from(json["payout_transaction"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
        "status":
            status == null ? [] : List<dynamic>.from(status!.map((x) => x)),
        "status_icon": statusIcon == null
            ? []
            : List<dynamic>.from(statusIcon!.map((x) => x)),
        "payout_transaction": payoutTransaction == null
            ? []
            : List<dynamic>.from(payoutTransaction!.map((x) => x)),
      };
}

class RequestList {
  String? id;
  String? tranIds;
  String? total;
  String? status;
  String? userId;
  dynamic preferMethod;
  dynamic settings;
  String? createdAt;

  RequestList({
    this.id,
    this.tranIds,
    this.total,
    this.status,
    this.userId,
    this.preferMethod,
    this.settings,
    this.createdAt,
  });

  factory RequestList.fromJson(Map<String, dynamic> json) => RequestList(
      id: json["id"],
      tranIds: json["tran_ids"],
      total: json["total"],
      status: json["status"],
      userId: json["user_id"],
      preferMethod: json["prefer_method"],
      settings: json["settings"],
      createdAt: json["created_at"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "tran_ids": tranIds,
        "total": total,
        "status": status,
        "user_id": userId,
        "prefer_method": preferMethod,
        "settings": settings,
        "created_at": createdAt,
      };
}
