class PhonepeRequestModel {
  bool? error;
  String? message;
  List<PhonepeRequestList>? data;

  PhonepeRequestModel({
    this.error,
    this.message,
    this.data,
  });

  factory PhonepeRequestModel.fromJson(Map<String, dynamic> json) =>
      PhonepeRequestModel(
        error: json['error'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<PhonepeRequestList>.from(
                json['data']!.map((x) => PhonepeRequestList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PhonepeRequestList {
  String? txId;
  String? amount;
  String? status;
  String? providerReferenceId;
  String? message;
  DateTime? createdAt;

  PhonepeRequestList({
    this.txId,
    this.amount,
    this.status,
    this.providerReferenceId,
    this.message,
    this.createdAt,
  });

  factory PhonepeRequestList.fromJson(Map<String, dynamic> json) =>
      PhonepeRequestList(
        txId: json['tx_id'],
        amount: json['amount'],
        status: json['status'],
        providerReferenceId: json['providerReferenceId'],
        message: json['message'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'tx_id': txId,
        'amount': amount,
        'status': status,
        'providerReferenceId': providerReferenceId,
        'message': message,
        'created_at': createdAt?.toIso8601String(),
      };
}
