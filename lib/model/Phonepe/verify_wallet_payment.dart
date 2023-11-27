class PhonepecheckPaymentStatusModel {
  bool? error;
  String? message;
  List<VerifyModelAddWallet>? data;

  PhonepecheckPaymentStatusModel({
    this.error,
    this.message,
    this.data,
  });

  factory PhonepecheckPaymentStatusModel.fromJson(Map<String, dynamic> json) =>
      PhonepecheckPaymentStatusModel(
        error: json['error'],
        message: json['message'],
        data: json['data'] == null
            ? []
            : List<VerifyModelAddWallet>.from(
                json['data']!.map((x) => VerifyModelAddWallet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class VerifyModelAddWallet {
  String? status;
  String? amount;
  String? providerReferenceId;
  DateTime? createdAt;

  VerifyModelAddWallet({
    this.status,
    this.amount,
    this.createdAt,
    this.providerReferenceId,
  });

  factory VerifyModelAddWallet.fromJson(Map<String, dynamic> json) =>
      VerifyModelAddWallet(
        status: json['status'],
        amount: json['amount'],
        providerReferenceId: json['providerReferenceId'],
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'amount': amount,
        'created_at': createdAt?.toIso8601String(),
      };
}
