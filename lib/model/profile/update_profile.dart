class UpdateProfileModel {
  bool? status;
  String? message;
  Data? data;

  UpdateProfileModel({this.status, this.message, this.data});

  UpdateProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
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
  dynamic lastPing;
  String? installLocationDetails;
  String? token;
  String? createdAt;
  String? deviceType;
  String? deviceToken;
  dynamic groups;
  dynamic verificationId;
  dynamic primaryPaymentMethod;

  Data(
      {this.id,
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
