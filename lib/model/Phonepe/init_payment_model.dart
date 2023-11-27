class PhonepeInitPaymentModel {
    bool? error;
    String? message;
    String? data;

    PhonepeInitPaymentModel({
        this.error,
        this.message,
        this.data,
    });

    factory PhonepeInitPaymentModel.fromJson(Map<String, dynamic> json) => PhonepeInitPaymentModel(
        error: json['error'],
        message: json['message'],
        data: json['data'],
    );

    Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': data,
    };
}
