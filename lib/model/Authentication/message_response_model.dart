class MessageModel {
    bool? status;
    String? message;

    MessageModel({
        this.status,
        this.message,
    });

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}