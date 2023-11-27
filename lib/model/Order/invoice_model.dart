class InvoicePdfModel {
    bool? status;
    String? message;
    String? data;

    InvoicePdfModel({
        this.status,
        this.message,
        this.data,
    });

    factory InvoicePdfModel.fromJson(Map<String, dynamic> json) => InvoicePdfModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
    };
}