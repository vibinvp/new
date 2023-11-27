class StroDetailsModel {
  bool? status;
  String? message;
  List<StoreData>? data;

  StroDetailsModel({
    this.status,
    this.message,
    this.data,
  });

  factory StroDetailsModel.fromJson(Map<String, dynamic> json) =>
      StroDetailsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<StoreData>.from(
                json["data"]!.map((x) => StoreData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class StoreData {
  String? id;
  String? companyName;
  String? companyLogo;
  String? email;
  String? comapnyReg;
  String? companyGst;
  String? privacyPolicy;
  String? customerCare;
  String? companyAddress;
  String? termsConditions;
  String? fcmServerKey;
  String? contactUs;
  String? aboutUs;
  String? faq;
  DateTime? createdAt;

  StoreData({
    this.id,
    this.companyName,
    this.companyLogo,
    this.email,
    this.comapnyReg,
    this.companyGst,
    this.privacyPolicy,
    this.customerCare,
    this.companyAddress,
    this.termsConditions,
    this.fcmServerKey,
    this.contactUs,
    this.aboutUs,
    this.faq,
    this.createdAt,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
        id: json["id"],
        companyName: json["company_name"],
        companyLogo: json["company_logo"],
        email: json["email"],
        comapnyReg: json["comapny_reg"],
        companyGst: json["company_gst"],
        privacyPolicy: json["privacy_policy"],
        customerCare: json["contact_number"],
        companyAddress: json["company_address"],
        termsConditions: json["tnc"],
        fcmServerKey: json["fcm_server_key"],
        contactUs: json["contact_us"],
        aboutUs: json["about_us"],
        faq: json["faq"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "company_logo": companyLogo,
        "email": email,
        "comapny_reg": comapnyReg,
        "company_gst": companyGst,
        "privacy_policy": privacyPolicy,
        "customer_care": customerCare,
        "company_address": companyAddress,
        "terms_conditions": termsConditions,
        "fcm_server_key": fcmServerKey,
        "contact_us": contactUs,
        "about_us": aboutUs,
        "faq": faq,
        "created_at": createdAt?.toIso8601String(),
      };
}
