class GetCartModel {
  bool? status;
  String? message;
  String? total;
  List<CartItem>? data;

  GetCartModel({this.status, this.message, this.total, this.data});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    if (json['data'] != null) {
      data = <CartItem>[];
      json['data'].forEach((v) {
        data!.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItem {
  String? cartId;
  String? userId;
  String? sessionId;
  String? productId;
  String? productVariation;
  dynamic referId;
  String? quantity;
  String? total;
  dynamic couponCode;
  dynamic couponName;
  String? couponDiscount;
  String? dateAdded;
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

  CartItem(
      {this.cartId,
      this.userId,
      this.sessionId,
      this.productId,
      this.productVariation,
      this.referId,
      this.quantity,
      this.total,
      this.couponCode,
      this.couponName,
      this.couponDiscount,
      this.dateAdded,
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
      this.viewStatistics});

  CartItem.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    userId = json['user_id'];
    sessionId = json['session_id'];
    productId = json['product_id'];
    productVariation = json['product_variation'];
    referId = json['refer_id'];
    quantity = json['quantity'];
    total = json['total'];
    couponCode = json['coupon_code'];
    couponName = json['coupon_name'];
    couponDiscount = json['coupon_discount'];
    dateAdded = json['date_added'];
    isCampaignProduct = json['is_campaign_product'];
    productUrl = json['product_url'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    productShortDescription = json['product_short_description'];
    productTags = json['product_tags'];
    productMsrp = json['product_msrp'];
    productPrice = json['product_price'];
    productSku = json['product_sku'];
    productSlug = json['product_slug'];
    productShareCount = json['product_share_count'];
    productClickCount = json['product_click_count'];
    productViewCount = json['product_view_count'];
    productSalesCount = json['product_sales_count'];
    productFeaturedImage = json['product_featured_image'];
    productBanner = json['product_banner'];
    productVideo = json['product_video'];
    productType = json['product_type'];
    productCommisionType = json['product_commision_type'];
    productCommisionValue = json['product_commision_value'];
    productStatus = json['product_status'];
    productIpaddress = json['product_ipaddress'];
    productCreatedDate = json['product_created_date'];
    productUpdatedDate = json['product_updated_date'];
    productCreatedBy = json['product_created_by'];
    productUpdatedBy = json['product_updated_by'];
    productClickCommisionType = json['product_click_commision_type'];
    productClickCommisionPpc = json['product_click_commision_ppc'];
    productClickCommisionPer = json['product_click_commision_per'];
    productTotalCommission = json['product_total_commission'];
    productRecursionType = json['product_recursion_type'];
    productRecursion = json['product_recursion'];
    recursionCustomTime = json['recursion_custom_time'];
    recursionEndtime = json['recursion_endtime'];
    view = json['view'];
    onStore = json['on_store'];
    downloadableFiles = json['downloadable_files'];
    allowShipping = json['allow_shipping'];
    allowUploadFile = json['allow_upload_file'];
    allowComment = json['allow_comment'];
    stateId = json['state_id'];
    productAvgRating = json['product_avg_rating'];
    productVariations = json['product_variations'];
    viewStatistics = json['view_statistics'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['user_id'] = userId;
    data['session_id'] = sessionId;
    data['product_id'] = productId;
    data['product_variation'] = productVariation;
    data['refer_id'] = referId;
    data['quantity'] = quantity;
    data['total'] = total;
    data['coupon_code'] = couponCode;
    data['coupon_name'] = couponName;
    data['coupon_discount'] = couponDiscount;
    data['date_added'] = dateAdded;
    data['is_campaign_product'] = isCampaignProduct;
    data['product_url'] = productUrl;
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data['product_short_description'] = productShortDescription;
    data['product_tags'] = productTags;
    data['product_msrp'] = productMsrp;
    data['product_price'] = productPrice;
    data['product_sku'] = productSku;
    data['product_slug'] = productSlug;
    data['product_share_count'] = productShareCount;
    data['product_click_count'] = productClickCount;
    data['product_view_count'] = productViewCount;
    data['product_sales_count'] = productSalesCount;
    data['product_featured_image'] = productFeaturedImage;
    data['product_banner'] = productBanner;
    data['product_video'] = productVideo;
    data['product_type'] = productType;
    data['product_commision_type'] = productCommisionType;
    data['product_commision_value'] = productCommisionValue;
    data['product_status'] = productStatus;
    data['product_ipaddress'] = productIpaddress;
    data['product_created_date'] = productCreatedDate;
    data['product_updated_date'] = productUpdatedDate;
    data['product_created_by'] = productCreatedBy;
    data['product_updated_by'] = productUpdatedBy;
    data['product_click_commision_type'] = productClickCommisionType;
    data['product_click_commision_ppc'] = productClickCommisionPpc;
    data['product_click_commision_per'] = productClickCommisionPer;
    data['product_total_commission'] = productTotalCommission;
    data['product_recursion_type'] = productRecursionType;
    data['product_recursion'] = productRecursion;
    data['recursion_custom_time'] = recursionCustomTime;
    data['recursion_endtime'] = recursionEndtime;
    data['view'] = view;
    data['on_store'] = onStore;
    data['downloadable_files'] = downloadableFiles;
    data['allow_shipping'] = allowShipping;
    data['allow_upload_file'] = allowUploadFile;
    data['allow_comment'] = allowComment;
    data['state_id'] = stateId;
    data['product_avg_rating'] = productAvgRating;
    data['product_variations'] = productVariations;
    data['view_statistics'] = viewStatistics;
    return data;
  }
}
