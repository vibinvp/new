class RegisterModel {
  final bool status;
  final String message;
  final Map<String, String> errors;

  RegisterModel({
    required this.status,
    required this.message,
    required this.errors,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> errorsJson = json['errors'] ?? {};
    Map<String, String> errorsMap = {};
    errorsJson.forEach((key, value) {
      if (value is String) {
        errorsMap[key] = value;
      }
    });

    return RegisterModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      errors: errorsMap,
    );
  }
}


class RegisterErrorModel {
    bool? status;
    String? message;
    Errors? errors;

    RegisterErrorModel({
        this.status,
        this.message,
        this.errors,
    });

    factory RegisterErrorModel.fromJson(Map<String, dynamic> json) => RegisterErrorModel(
        status: json["status"],
        message: json["message"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors?.toJson(),
    };
}

class Errors {
    Errors();

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    );

    Map<String, dynamic> toJson() => {
    };
}
