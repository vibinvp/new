class WalletTransactionModel {
  bool? status;
  String? message;
  List<TransactionData>? data;

  WalletTransactionModel({
    this.status,
    this.message,
    this.data,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) =>
      WalletTransactionModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<TransactionData>.from(
                json["data"]!.map((x) => TransactionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TransactionData {
  String? id;
  String? userId;
  dynamic fromUserId;
  String? amount;
  String? comment;
  String? type;
  dynamic disType;
  String? status;
  String? commissionStatus;
  String? referenceId;
  dynamic referenceId2;
  String? ipDetails;
  String? commFrom;
  dynamic domainName;
  dynamic pageName;
  String? isAction;
  String? parentId;
  String? groupId;
  String? isVendor;
  dynamic wv;
  String? createdAt;

  TransactionData({
    this.id,
    this.userId,
    this.fromUserId,
    this.amount,
    this.comment,
    this.type,
    this.disType,
    this.status,
    this.commissionStatus,
    this.referenceId,
    this.referenceId2,
    this.ipDetails,
    this.commFrom,
    this.domainName,
    this.pageName,
    this.isAction,
    this.parentId,
    this.groupId,
    this.isVendor,
    this.wv,
    this.createdAt,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      TransactionData(
        id: json["id"],
        userId: json["user_id"],
        fromUserId: json["from_user_id"],
        amount: json["amount"],
        comment: json["comment"],
        type: json["type"],
        disType: json["dis_type"],
        status: json["status"],
        commissionStatus: json["commission_status"],
        referenceId: json["reference_id"],
        referenceId2: json["reference_id_2"],
        ipDetails: json["ip_details"],
        commFrom: json["comm_from"],
        domainName: json["domain_name"],
        pageName: json["page_name"],
        isAction: json["is_action"],
        parentId: json["parent_id"],
        groupId: json["group_id"],
        isVendor: json["is_vendor"],
        wv: json["wv"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "from_user_id": fromUserId,
        "amount": amount,
        "comment": comment,
        "type": type,
        "dis_type": disType,
        "status": status,
        "commission_status": commissionStatus,
        "reference_id": referenceId,
        "reference_id_2": referenceId2,
        "ip_details": ipDetails,
        "comm_from": commFrom,
        "domain_name": domainName,
        "page_name": pageName,
        "is_action": isAction,
        "parent_id": parentId,
        "group_id": groupId,
        "is_vendor": isVendor,
        "wv": wv,
        "created_at": createdAt,
      };
}
