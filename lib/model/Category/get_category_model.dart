class GetCategoryModel {
  bool? status;
  String? message;
  dynamic totalProduct;
  List<CategoryData>? data;

  GetCategoryModel({
    this.status,
    this.message,
    this.totalProduct,
    this.data,
  });

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetCategoryModel(
        status: json["status"],
        message: json["message"],
        totalProduct: json["total_product"],
        data: json["data"] == null
            ? []
            : List<CategoryData>.from(
                json["data"]!.map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryData {
  String? id;
  String? name;
  String? slug;
  String? description;
  String? image;
  String? backgroundImage;
  String? color;
  String? parentId;
  String? tag;
  String? createdAt;
  String? prodCount;

  CategoryData({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.backgroundImage,
    this.color,
    this.parentId,
    this.tag,
    this.createdAt,
    this.prodCount,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        backgroundImage: json["background_image"],
        color: json["color"],
        parentId: json["parent_id"],
        tag: json["tag"],
        createdAt: json["created_at"],
        prodCount: json["prod_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "image": image,
        "background_image": backgroundImage,
        "color": color,
        "parent_id": parentId,
        "tag": tag,
        "created_at": createdAt,
      };
}
