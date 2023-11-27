
class BankDetailsModel {
    bool? status;
    String? message;
    List<Datum>? data;

    BankDetailsModel({
        this.status,
        this.message,
        this.data,
    });

    factory BankDetailsModel.fromJson(Map<String, dynamic> json) => BankDetailsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? paymentId;
    String? paymentBankName;
    String? paymentAccountNumber;
    String? paymentAccountName;
    String? paymentIfscCode;
    String? paymentStatus;
    String? paymentIpaddress;
    DateTime? paymentCreatedDate;
    String? paymentUpdatedDate;
    String? paymentCreatedBy;
    String? paymentUpdatedBy;

    Datum({
        this.paymentId,
        this.paymentBankName,
        this.paymentAccountNumber,
        this.paymentAccountName,
        this.paymentIfscCode,
        this.paymentStatus,
        this.paymentIpaddress,
        this.paymentCreatedDate,
        this.paymentUpdatedDate,
        this.paymentCreatedBy,
        this.paymentUpdatedBy,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        paymentId: json["payment_id"],
        paymentBankName: json["payment_bank_name"],
        paymentAccountNumber: json["payment_account_number"],
        paymentAccountName: json["payment_account_name"],
        paymentIfscCode: json["payment_ifsc_code"],
        paymentStatus: json["payment_status"],
        paymentIpaddress: json["payment_ipaddress"],
        paymentCreatedDate: json["payment_created_date"] == null ? null : DateTime.parse(json["payment_created_date"]),
        paymentUpdatedDate: json["payment_updated_date"],
        paymentCreatedBy: json["payment_created_by"],
        paymentUpdatedBy: json["payment_updated_by"],
    );

    Map<String, dynamic> toJson() => {
        "payment_id": paymentId,
        "payment_bank_name": paymentBankName,
        "payment_account_number": paymentAccountNumber,
        "payment_account_name": paymentAccountName,
        "payment_ifsc_code": paymentIfscCode,
        "payment_status": paymentStatus,
        "payment_ipaddress": paymentIpaddress,
        "payment_created_date": paymentCreatedDate?.toIso8601String(),
        "payment_updated_date": paymentUpdatedDate,
        "payment_created_by": paymentCreatedBy,
        "payment_updated_by": paymentUpdatedBy,
    };
}
