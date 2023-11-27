class SearchModel {
  bool? status;
  String? message;
  List<Searchdata>? data;

  SearchModel({
    this.status,
    this.message,
    this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Searchdata>.from(
                json["data"]!.map((x) => Searchdata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Searchdata {
  String? bookingId;
  String? catId;
  String? serviceImage;
  String? serviceName;
  String? serviceDescription;
  String? servicePrice;
  String? serviceFeatures;
  String? serviceTax;
  DateTime? addedOn;
  String? bookingType;

  Searchdata({
    this.bookingId,
    this.catId,
    this.serviceImage,
    this.serviceName,
    this.serviceDescription,
    this.servicePrice,
    this.serviceFeatures,
    this.serviceTax,
    this.addedOn,
    this.bookingType,
  });

  factory Searchdata.fromJson(Map<String, dynamic> json) => Searchdata(
        bookingId: json["booking_id"],
        catId: json["cat_id"],
        serviceImage: json["service_image"],
        serviceName: json["service_name"],
        serviceDescription: json["service_description"],
        servicePrice: json["service_price"],
        serviceFeatures: json["service_features"],
        serviceTax: json["service_tax"],
        addedOn:
            json["added_on"] == null ? null : DateTime.parse(json["added_on"]),
        bookingType: json["booking_type"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "cat_id": catId,
        "service_image": serviceImage,
        "service_name": serviceName,
        "service_description": serviceDescription,
        "service_price": servicePrice,
        "service_features": serviceFeatures,
        "service_tax": serviceTax,
        "added_on": addedOn?.toIso8601String(),
        "booking_type": bookingType,
      };
}
