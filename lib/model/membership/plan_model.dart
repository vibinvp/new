class MembershipPlansModel {
  bool? status;
  String? message;
  Data? data;

  MembershipPlansModel({
    this.status,
    this.message,
    this.data,
  });

  factory MembershipPlansModel.fromJson(Map<String, dynamic> json) =>
      MembershipPlansModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? notcheckmember;
  MembershipSetting? membershipSetting;
  List<PlanData>? plans;
  Methods? methods;

  Data({
    this.notcheckmember,
    this.membershipSetting,
    this.plans,
    this.methods,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notcheckmember: json["notcheckmember"],
        membershipSetting: json["MembershipSetting"] == null
            ? null
            : MembershipSetting.fromJson(json["MembershipSetting"]),
        plans: json["plans"] == null
            ? []
            : List<PlanData>.from(
                json["plans"]!.map((x) => PlanData.fromJson(x))),
        methods:
            json["methods"] == null ? null : Methods.fromJson(json["methods"]),
      );

  Map<String, dynamic> toJson() => {
        "notcheckmember": notcheckmember,
        "MembershipSetting": membershipSetting?.toJson(),
        "plans": plans == null
            ? []
            : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "methods": methods?.toJson(),
      };
}

class MembershipSetting {
  String? status;
  String? notificationbefore;
  String? defaultPlanId;
  String? defaultAffiliatePlanId;
  String? defaultVendorPlanId;

  MembershipSetting({
    this.status,
    this.notificationbefore,
    this.defaultPlanId,
    this.defaultAffiliatePlanId,
    this.defaultVendorPlanId,
  });

  factory MembershipSetting.fromJson(Map<String, dynamic> json) =>
      MembershipSetting(
        status: json["status"],
        notificationbefore: json["notificationbefore"],
        defaultPlanId: json["default_plan_id"],
        defaultAffiliatePlanId: json["default_affiliate_plan_id"],
        defaultVendorPlanId: json["default_vendor_plan_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "notificationbefore": notificationbefore,
        "default_plan_id": defaultPlanId,
        "default_affiliate_plan_id": defaultAffiliatePlanId,
        "default_vendor_plan_id": defaultVendorPlanId,
      };
}

class Methods {
  BankTransfer? bankTransfer;

  Methods({
    this.bankTransfer,
  });

  factory Methods.fromJson(Map<String, dynamic> json) => Methods(
        bankTransfer: json["bank_transfer"] == null
            ? null
            : BankTransfer.fromJson(json["bank_transfer"]),
      );

  Map<String, dynamic> toJson() => {
        "bank_transfer": bankTransfer?.toJson(),
      };
}

class BankTransfer {
  String? isInstall;
  String? proof;
  String? bankNames;
  String? bankDetails;
  String? additionalBankDetails;
  String? title;
  String? icon;
  String? name;

  BankTransfer({
    this.isInstall,
    this.proof,
    this.bankNames,
    this.bankDetails,
    this.additionalBankDetails,
    this.title,
    this.icon,
    this.name,
  });

  factory BankTransfer.fromJson(Map<String, dynamic> json) => BankTransfer(
        isInstall: json["is_install"],
        proof: json["proof"],
        bankNames: json["bank_names"],
        bankDetails: json["bank_details"],
        additionalBankDetails: json["additional_bank_details"],
        title: json["title"],
        icon: json["icon"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "is_install": isInstall,
        "proof": proof,
        "bank_names": bankNames,
        "bank_details": bankDetails,
        "additional_bank_details": additionalBankDetails,
        "title": title,
        "icon": icon,
        "name": name,
      };
}

class PlanData {
  int? id;
  String? name;
  String? type;
  String? billingPeriod;
  String? price;
  String? special;
  String? customPeriod;
  String? haveTrail;
  String? freeTrail;
  String? totalDay;
  String? bonus;
  String? commissionSaleStatus;
  String? levelId;
  String? status;
  String? userType;
  dynamic campaign;
  dynamic product;
  String? description;
  String? planIcon;
  String? labelText;
  String? labelBackground;
  String? labelColor;
  String? sortOrder;
  DateTime? updatedAt;
  DateTime? createdAt;

  PlanData({
    this.id,
    this.name,
    this.type,
    this.billingPeriod,
    this.price,
    this.special,
    this.customPeriod,
    this.haveTrail,
    this.freeTrail,
    this.totalDay,
    this.bonus,
    this.commissionSaleStatus,
    this.levelId,
    this.status,
    this.userType,
    this.campaign,
    this.product,
    this.description,
    this.planIcon,
    this.labelText,
    this.labelBackground,
    this.labelColor,
    this.sortOrder,
    this.updatedAt,
    this.createdAt,
  });

  factory PlanData.fromJson(Map<String, dynamic> json) => PlanData(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        billingPeriod: json["billing_period"],
        price: json["price"],
        special: json["special"],
        customPeriod: json["custom_period"],
        haveTrail: json["have_trail"],
        freeTrail: json["free_trail"],
        totalDay: json["total_day"],
        bonus: json["bonus"],
        commissionSaleStatus: json["commission_sale_status"],
        levelId: json["level_id"],
        status: json["status"],
        userType: json["user_type"],
        campaign: json["campaign"],
        product: json["product"],
        description: json["description"],
        planIcon: json["plan_icon"],
        labelText: json["label_text"],
        labelBackground: json["label_background"],
        labelColor: json["label_color"],
        sortOrder: json["sort_order"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "billing_period": billingPeriod,
        "price": price,
        "special": special,
        "custom_period": customPeriod,
        "have_trail": haveTrail,
        "free_trail": freeTrail,
        "total_day": totalDay,
        "bonus": bonus,
        "commission_sale_status": commissionSaleStatus,
        "level_id": levelId,
        "status": status,
        "user_type": userType,
        "campaign": campaign,
        "product": product,
        "description": description,
        "plan_icon": planIcon,
        "label_text": labelText,
        "label_background": labelBackground,
        "label_color": labelColor,
        "sort_order": sortOrder,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
      };
}
