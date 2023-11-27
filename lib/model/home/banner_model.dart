class GetBannersModel {
  bool? status;
  String? message;
  List<BannerData>? data;

  GetBannersModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetBannersModel.fromJson(Map<String, dynamic> json) =>
      GetBannersModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BannerData>.from(
                json["data"]!.map((x) => BannerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BannerData {
  String? index;
  String? title;
  String? subTitle;
  String? content;
  String? sliderBackgroundImage;
  String? buttonText;
  String? buttonLink;
  String? sliderTextColor;
  String? buttonTextColor;
  String? buttonBgColor;

  BannerData({
    this.index,
    this.title,
    this.subTitle,
    this.content,
    this.sliderBackgroundImage,
    this.buttonText,
    this.buttonLink,
    this.sliderTextColor,
    this.buttonTextColor,
    this.buttonBgColor,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        index: json["index"],
        title: json["title"],
        subTitle: json["sub_title"],
        content: json["content"],
        sliderBackgroundImage: json["slider_background_image"],
        buttonText: json["button_text"],
        buttonLink: json["button_link"],
        sliderTextColor: json["slider_text_color"],
        buttonTextColor: json["button_text_color"],
        buttonBgColor: json["button_bg_color"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "title": title,
        "sub_title": subTitle,
        "content": content,
        "slider_background_image": sliderBackgroundImage,
        "button_text": buttonText,
        "button_link": buttonLink,
        "slider_text_color": sliderTextColor,
        "button_text_color": buttonTextColor,
        "button_bg_color": buttonBgColor,
      };
}
