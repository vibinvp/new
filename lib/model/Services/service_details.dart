class GetPerodectsModel {
  bool? status;
  String? message;
  List<ProductsData>? data;

  GetPerodectsModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetPerodectsModel.fromJson(Map<String, dynamic> json) =>
      GetPerodectsModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ProductsData>.from(
                json["data"]!.map((x) => ProductsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ProductsData {
  String? productId;
  String? isCampaignProduct;
  dynamic productUrl;
  String? productName;
  String? productDescription;
  String? productShortDescription;
  String? productTags;
  String? productMsrp;
  String? productPrice;
  String? productSku;
  String? productSlug;
  String? productShareCount;
  String? productClickCount;
  String? productViewCount;
  String? productSalesCount;
  String? productFeaturedImage;
  String? productBanner;
  String? productVideo;
  String? productType;
  String? productCommisionType;
  String? productCommisionValue;
  String? productStatus;
  String? productIpaddress;
  String? productCreatedDate;
  String? productUpdatedDate;
  String? productCreatedBy;
  String? productUpdatedBy;
  String? productClickCommisionType;
  String? productClickCommisionPpc;
  String? productClickCommisionPer;
  String? productTotalCommission;
  String? productRecursionType;
  String? productRecursion;
  String? recursionCustomTime;
  dynamic recursionEndtime;
  String? view;
  String? onStore;
  String? downloadableFiles;
  String? allowShipping;
  String? allowUploadFile;
  String? allowComment;
  String? stateId;
  String? productAvgRating;
  String? productVariations;
  String? viewStatistics;
  String? id;
  String? categoryId;

  ProductsData({
    this.productId,
    this.isCampaignProduct,
    this.productUrl,
    this.productName,
    this.productDescription,
    this.productShortDescription,
    this.productTags,
    this.productMsrp,
    this.productPrice,
    this.productSku,
    this.productSlug,
    this.productShareCount,
    this.productClickCount,
    this.productViewCount,
    this.productSalesCount,
    this.productFeaturedImage,
    this.productBanner,
    this.productVideo,
    this.productType,
    this.productCommisionType,
    this.productCommisionValue,
    this.productStatus,
    this.productIpaddress,
    this.productCreatedDate,
    this.productUpdatedDate,
    this.productCreatedBy,
    this.productUpdatedBy,
    this.productClickCommisionType,
    this.productClickCommisionPpc,
    this.productClickCommisionPer,
    this.productTotalCommission,
    this.productRecursionType,
    this.productRecursion,
    this.recursionCustomTime,
    this.recursionEndtime,
    this.view,
    this.onStore,
    this.downloadableFiles,
    this.allowShipping,
    this.allowUploadFile,
    this.allowComment,
    this.stateId,
    this.productAvgRating,
    this.productVariations,
    this.viewStatistics,
    this.id,
    this.categoryId,
  });

  factory ProductsData.fromJson(Map<String, dynamic> json) => ProductsData(
        productId: json["product_id"],
        isCampaignProduct: json["is_campaign_product"],
        productUrl: json["product_url"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productShortDescription: json["product_short_description"],
        productTags: json["product_tags"],
        productMsrp: json["product_msrp"],
        productPrice: json["product_price"],
        productSku: json["product_sku"],
        productSlug: json["product_slug"],
        productShareCount: json["product_share_count"],
        productClickCount: json["product_click_count"],
        productViewCount: json["product_view_count"],
        productSalesCount: json["product_sales_count"],
        productFeaturedImage: json["product_featured_image"],
        productBanner: json["product_banner"],
        productVideo: json["product_video"],
        productType: json["product_type"],
        productCommisionType: json["product_commision_type"],
        productCommisionValue: json["product_commision_value"],
        productStatus: json["product_status"],
        productIpaddress: json["product_ipaddress"],
        productCreatedDate: json["product_created_date"],
        productUpdatedDate: json["product_updated_date"],
        productCreatedBy: json["product_created_by"],
        productUpdatedBy: json["product_updated_by"],
        productClickCommisionType: json["product_click_commision_type"],
        productClickCommisionPpc: json["product_click_commision_ppc"],
        productClickCommisionPer: json["product_click_commision_per"],
        productTotalCommission: json["product_total_commission"],
        productRecursionType: json["product_recursion_type"],
        productRecursion: json["product_recursion"],
        recursionCustomTime: json["recursion_custom_time"],
        recursionEndtime: json["recursion_endtime"],
        view: json["view"],
        onStore: json["on_store"],
        downloadableFiles: json["downloadable_files"],
        allowShipping: json["allow_shipping"],
        allowUploadFile: json["allow_upload_file"],
        allowComment: json["allow_comment"],
        stateId: json["state_id"],
        productAvgRating: json["product_avg_rating"],
        productVariations: json["product_variations"],
        viewStatistics: json["view_statistics"],
        id: json["id"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "is_campaign_product": isCampaignProduct,
        "product_url": productUrl,
        "product_name": productName,
        "product_description": productDescription,
        "product_short_description": productShortDescription,
        "product_tags": productTags,
        "product_msrp": productMsrp,
        "product_price": productPrice,
        "product_sku": productSku,
        "product_slug": productSlug,
        "product_share_count": productShareCount,
        "product_click_count": productClickCount,
        "product_view_count": productViewCount,
        "product_sales_count": productSalesCount,
        "product_featured_image": productFeaturedImage,
        "product_banner": productBanner,
        "product_video": productVideo,
        "product_type": productType,
        "product_commision_type": productCommisionType,
        "product_commision_value": productCommisionValue,
        "product_status": productStatus,
        "product_ipaddress": productIpaddress,
        "product_created_date": productCreatedDate,
        "product_updated_date": productUpdatedDate,
        "product_created_by": productCreatedBy,
        "product_updated_by": productUpdatedBy,
        "product_click_commision_type": productClickCommisionType,
        "product_click_commision_ppc": productClickCommisionPpc,
        "product_click_commision_per": productClickCommisionPer,
        "product_total_commission": productTotalCommission,
        "product_recursion_type": productRecursionType,
        "product_recursion": productRecursion,
        "recursion_custom_time": recursionCustomTime,
        "recursion_endtime": recursionEndtime,
        "view": view,
        "on_store": onStore,
        "downloadable_files": downloadableFiles,
        "allow_shipping": allowShipping,
        "allow_upload_file": allowUploadFile,
        "allow_comment": allowComment,
        "state_id": stateId,
        "product_avg_rating": productAvgRating,
        "product_variations": productVariations,
        "view_statistics": viewStatistics,
        "id": id,
        "category_id": categoryId,
      };
}
