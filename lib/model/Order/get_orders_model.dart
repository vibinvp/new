class GetOrderModel {
  bool? status;
  String? message;
  List<OrderList>? data;

  GetOrderModel({this.status, this.message, this.data});

  GetOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderList>[];
      json['data'].forEach((v) {
        data!.add(OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderList {
  String? id;
  String? txnId;
  String? userId;
  String? paymentMode;
  String? orderStatusId;
  String? productId;
  String? referId;
  String? price;
  String? total;
  String? quantity;
  String? commission;
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
  String? planId;
  String? refid;
  String? levelId;
  String? type;
  String? firstname;
  String? lastname;
  String? email;
  String? username;
  String? password;
  String? phone;
  String? twaddress;
  String? address1;
  String? address2;
  String? ucity;
  String? ucountry;
  String? state;
  String? uzip;
  String? avatar;
  String? online;
  String? uniqueUrl;
  String? bitlyUniqueUrl;
  String? updatedAt;
  String? googleId;
  String? facebookId;
  String? twitterId;
  String? umode;
  String? phoneNumber;
  String? addressone;
  String? addresstwo;
  String? city;
  String? country;
  String? stateProvince;
  String? zip;
  String? fLink;
  String? tLink;
  String? lLink;
  dynamic productsWishlist;
  String? productCommission;
  String? affiliateCommission;
  String? productCommissionPaid;
  String? affiliateCommissionPaid;
  String? productTotalClick;
  String? productTotalSale;
  String? affiliateTotalClick;
  String? saleCommission;
  String? saleCommissionPaid;
  String? status;
  String? regApproved;
  String? isVendor;
  dynamic storeMeta;
  dynamic storeSlug;
  dynamic storeName;
  dynamic storeContactUsMap;
  dynamic storeAddress;
  dynamic storeEmail;
  dynamic storeContactNumber;
  String? storeTermsCondition;
  String? value;
  String? lastPing;
  String? installLocationDetails;
  String? token;
  String? createdAt;
  String? deviceType;
  String? deviceToken;
  dynamic groups;
  dynamic verificationId;
  dynamic primaryPaymentMethod;

  OrderList(
      {this.id,
      this.txnId,
      this.userId,
      this.paymentMode,
      this.orderStatusId,
      this.productId,
      this.referId,
      this.price,
      this.total,
      this.quantity,
      this.commission,
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
      this.planId,
      this.refid,
      this.levelId,
      this.type,
      this.firstname,
      this.lastname,
      this.email,
      this.username,
      this.password,
      this.phone,
      this.twaddress,
      this.address1,
      this.address2,
      this.ucity,
      this.ucountry,
      this.state,
      this.uzip,
      this.avatar,
      this.online,
      this.uniqueUrl,
      this.bitlyUniqueUrl,
      this.updatedAt,
      this.googleId,
      this.facebookId,
      this.twitterId,
      this.umode,
      this.phoneNumber,
      this.addressone,
      this.addresstwo,
      this.city,
      this.country,
      this.stateProvince,
      this.zip,
      this.fLink,
      this.tLink,
      this.lLink,
      this.productsWishlist,
      this.productCommission,
      this.affiliateCommission,
      this.productCommissionPaid,
      this.affiliateCommissionPaid,
      this.productTotalClick,
      this.productTotalSale,
      this.affiliateTotalClick,
      this.saleCommission,
      this.saleCommissionPaid,
      this.status,
      this.regApproved,
      this.isVendor,
      this.storeMeta,
      this.storeSlug,
      this.storeName,
      this.storeContactUsMap,
      this.storeAddress,
      this.storeEmail,
      this.storeContactNumber,
      this.storeTermsCondition,
      this.value,
      this.lastPing,
      this.installLocationDetails,
      this.token,
      this.createdAt,
      this.deviceType,
      this.deviceToken,
      this.groups,
      this.verificationId,
      this.primaryPaymentMethod});

  OrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    txnId = json['txn_id'];
    userId = json['user_id'];
    paymentMode = json['payment_mode'];
    orderStatusId = json['order_status_id'];
    productId = json['product_id'];
    referId = json['refer_id'];
    price = json['price'];
    total = json['total'];
    quantity = json['quantity'];
    commission = json['commission'];
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
    planId = json['plan_id'];
    refid = json['refid'];
    levelId = json['level_id'];
    type = json['type'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    twaddress = json['twaddress'];
    address1 = json['address1'];
    address2 = json['address2'];
    ucity = json['ucity'];
    ucountry = json['ucountry'];
    state = json['state'];
    uzip = json['uzip'];
    avatar = json['avatar'];
    online = json['online'];
    uniqueUrl = json['unique_url'];
    bitlyUniqueUrl = json['bitly_unique_url'];
    updatedAt = json['updated_at'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    twitterId = json['twitter_id'];
    umode = json['umode'];
    phoneNumber = json['PhoneNumber'];
    addressone = json['Addressone'];
    addresstwo = json['Addresstwo'];
    city = json['City'];
    country = json['Country'];
    stateProvince = json['StateProvince'];
    zip = json['Zip'];
    fLink = json['f_link'];
    tLink = json['t_link'];
    lLink = json['l_link'];
    productsWishlist = json['products_wishlist'];
    productCommission = json['product_commission'];
    affiliateCommission = json['affiliate_commission'];
    productCommissionPaid = json['product_commission_paid'];
    affiliateCommissionPaid = json['affiliate_commission_paid'];
    productTotalClick = json['product_total_click'];
    productTotalSale = json['product_total_sale'];
    affiliateTotalClick = json['affiliate_total_click'];
    saleCommission = json['sale_commission'];
    saleCommissionPaid = json['sale_commission_paid'];
    status = json['status'];
    regApproved = json['reg_approved'];
    isVendor = json['is_vendor'];
    storeMeta = json['store_meta'];
    storeSlug = json['store_slug'];
    storeName = json['store_name'];
    storeContactUsMap = json['store_contact_us_map'];
    storeAddress = json['store_address'];
    storeEmail = json['store_email'];
    storeContactNumber = json['store_contact_number'];
    storeTermsCondition = json['store_terms_condition'];
    value = json['value'];
    lastPing = json['last_ping'];
    installLocationDetails = json['install_location_details'];
    token = json['token'];
    createdAt = json['created_at'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    groups = json['groups'];
    verificationId = json['verification_id'];
    primaryPaymentMethod = json['primary_payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['txn_id'] = txnId;
    data['user_id'] = userId;
    data['payment_mode'] = paymentMode;
    data['order_status_id'] = orderStatusId;
    data['product_id'] = productId;
    data['refer_id'] = referId;
    data['price'] = price;
    data['total'] = total;
    data['quantity'] = quantity;
    data['commission'] = commission;
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
    data['plan_id'] = planId;
    data['refid'] = refid;
    data['level_id'] = levelId;
    data['type'] = type;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['username'] = username;
    data['password'] = password;
    data['phone'] = phone;
    data['twaddress'] = twaddress;
    data['address1'] = address1;
    data['address2'] = address2;
    data['ucity'] = ucity;
    data['ucountry'] = ucountry;
    data['state'] = state;
    data['uzip'] = uzip;
    data['avatar'] = avatar;
    data['online'] = online;
    data['unique_url'] = uniqueUrl;
    data['bitly_unique_url'] = bitlyUniqueUrl;
    data['updated_at'] = updatedAt;
    data['google_id'] = googleId;
    data['facebook_id'] = facebookId;
    data['twitter_id'] = twitterId;
    data['umode'] = umode;
    data['PhoneNumber'] = phoneNumber;
    data['Addressone'] = addressone;
    data['Addresstwo'] = addresstwo;
    data['City'] = city;
    data['Country'] = country;
    data['StateProvince'] = stateProvince;
    data['Zip'] = zip;
    data['f_link'] = fLink;
    data['t_link'] = tLink;
    data['l_link'] = lLink;
    data['products_wishlist'] = productsWishlist;
    data['product_commission'] = productCommission;
    data['affiliate_commission'] = affiliateCommission;
    data['product_commission_paid'] = productCommissionPaid;
    data['affiliate_commission_paid'] = affiliateCommissionPaid;
    data['product_total_click'] = productTotalClick;
    data['product_total_sale'] = productTotalSale;
    data['affiliate_total_click'] = affiliateTotalClick;
    data['sale_commission'] = saleCommission;
    data['sale_commission_paid'] = saleCommissionPaid;
    data['status'] = status;
    data['reg_approved'] = regApproved;
    data['is_vendor'] = isVendor;
    data['store_meta'] = storeMeta;
    data['store_slug'] = storeSlug;
    data['store_name'] = storeName;
    data['store_contact_us_map'] = storeContactUsMap;
    data['store_address'] = storeAddress;
    data['store_email'] = storeEmail;
    data['store_contact_number'] = storeContactNumber;
    data['store_terms_condition'] = storeTermsCondition;
    data['value'] = value;
    data['last_ping'] = lastPing;
    data['install_location_details'] = installLocationDetails;
    data['token'] = token;
    data['created_at'] = createdAt;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['groups'] = groups;
    data['verification_id'] = verificationId;
    data['primary_payment_method'] = primaryPaymentMethod;
    return data;
  }
}
