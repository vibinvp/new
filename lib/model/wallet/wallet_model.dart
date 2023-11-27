class WalletModel {
  bool? status;
  String? message;
  Data? data;

  WalletModel({
    this.status,
    this.message,
    this.data,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
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
  bool? referStatus;
  String? uniqueResellerLink;
  bool? isMembershipAccess;
  UserPlan? userPlan;
  UserTotals? userTotals;
  ReferTotal? referTotal;
  String? userTotalsWeek;
  String? userTotalsMonth;
  String? userTotalsYear;

  Data({
    this.referStatus,
    this.uniqueResellerLink,
    this.isMembershipAccess,
    this.userPlan,
    this.userTotals,
    this.referTotal,
    this.userTotalsWeek,
    this.userTotalsMonth,
    this.userTotalsYear,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        referStatus: json["refer_status"],
        uniqueResellerLink: json["unique_reseller_link"],
        isMembershipAccess: json["isMembershipAccess"],
        userPlan: json["user_plan"] == null
            ? null
            : UserPlan.fromJson(json["user_plan"]),
        userTotals: json["user_totals"] == null
            ? null
            : UserTotals.fromJson(json["user_totals"]),
        referTotal: json["refer_total"] == null
            ? null
            : ReferTotal.fromJson(json["refer_total"]),
        userTotalsWeek: json["user_totals_week"],
        userTotalsMonth: json["user_totals_month"],
        userTotalsYear: json["user_totals_year"],
      );

  Map<String, dynamic> toJson() => {
        "refer_status": referStatus,
        "unique_reseller_link": uniqueResellerLink,
        "isMembershipAccess": isMembershipAccess,
        "user_plan": userPlan?.toJson(),
        "user_totals": userTotals?.toJson(),
        "refer_total": referTotal?.toJson(),
        "user_totals_week": userTotalsWeek,
        "user_totals_month": userTotalsMonth,
        "user_totals_year": userTotalsYear,
      };
}

class ReferTotal {
  TotalProductClick? totalProductClick;
  TotalGaneralClick? totalGaneralClick;
  TotalAction? totalAction;
  TotalProductSale? totalProductSale;

  ReferTotal({
    this.totalProductClick,
    this.totalGaneralClick,
    this.totalAction,
    this.totalProductSale,
  });

  factory ReferTotal.fromJson(Map<String, dynamic> json) => ReferTotal(
        totalProductClick: json["total_product_click"] == null
            ? null
            : TotalProductClick.fromJson(json["total_product_click"]),
        totalGaneralClick: json["total_ganeral_click"] == null
            ? null
            : TotalGaneralClick.fromJson(json["total_ganeral_click"]),
        totalAction: json["total_action"] == null
            ? null
            : TotalAction.fromJson(json["total_action"]),
        totalProductSale: json["total_product_sale"] == null
            ? null
            : TotalProductSale.fromJson(json["total_product_sale"]),
      );

  Map<String, dynamic> toJson() => {
        "total_product_click": totalProductClick?.toJson(),
        "total_ganeral_click": totalGaneralClick?.toJson(),
        "total_action": totalAction?.toJson(),
        "total_product_sale": totalProductSale?.toJson(),
      };
}

class TotalAction {
  String? clickCount;

  TotalAction({
    this.clickCount,
  });

  factory TotalAction.fromJson(Map<String, dynamic> json) => TotalAction(
        clickCount: json["click_count"],
      );

  Map<String, dynamic> toJson() => {
        "click_count": clickCount,
      };
}

class TotalGaneralClick {
  String? totalClicks;

  TotalGaneralClick({
    this.totalClicks,
  });

  factory TotalGaneralClick.fromJson(Map<String, dynamic> json) =>
      TotalGaneralClick(
        totalClicks: json["total_clicks"],
      );

  Map<String, dynamic> toJson() => {
        "total_clicks": totalClicks,
      };
}

class TotalProductClick {
  dynamic amounts;
  num? clicks;

  TotalProductClick({
    this.amounts,
    this.clicks,
  });

  factory TotalProductClick.fromJson(Map<String, dynamic> json) =>
      TotalProductClick(
        amounts: json["amounts"],
        clicks: json["clicks"],
      );

  Map<String, dynamic> toJson() => {
        "amounts": amounts,
        "clicks": clicks,
      };
}

class TotalProductSale {
  dynamic amounts;
  String? counts;
  dynamic paid;
  dynamic request;
  dynamic unpaid;

  TotalProductSale({
    this.amounts,
    this.counts,
    this.paid,
    this.request,
    this.unpaid,
  });

  factory TotalProductSale.fromJson(Map<String, dynamic> json) =>
      TotalProductSale(
        amounts: json["amounts"],
        counts: json["counts"],
        paid: json["paid"],
        request: json["request"],
        unpaid: json["unpaid"],
      );

  Map<String, dynamic> toJson() => {
        "amounts": amounts,
        "counts": counts,
        "paid": paid,
        "request": request,
        "unpaid": unpaid,
      };
}

class UserPlan {
  String? id;
  String? planId;
  String? userId;
  String? totalDay;
  DateTime? expireAt;
  DateTime? startedAt;
  String? statusId;
  String? isActive;
  String? isLifetime;
  String? paymentMethod;
  String? paymentDetails;
  String? total;
  String? bonusCommission;
  String? expireMailSent;
  DateTime? createdAt;

  UserPlan({
    this.id,
    this.planId,
    this.userId,
    this.totalDay,
    this.expireAt,
    this.startedAt,
    this.statusId,
    this.isActive,
    this.isLifetime,
    this.paymentMethod,
    this.paymentDetails,
    this.total,
    this.bonusCommission,
    this.expireMailSent,
    this.createdAt,
  });

  factory UserPlan.fromJson(Map<String, dynamic> json) => UserPlan(
        id: json["id"],
        planId: json["plan_id"],
        userId: json["user_id"],
        totalDay: json["total_day"],
        expireAt: json["expire_at"] == null
            ? null
            : DateTime.parse(json["expire_at"]),
        startedAt: json["started_at"] == null
            ? null
            : DateTime.parse(json["started_at"]),
        statusId: json["status_id"],
        isActive: json["is_active"],
        isLifetime: json["is_lifetime"],
        paymentMethod: json["payment_method"],
        paymentDetails: json["payment_details"],
        total: json["total"],
        bonusCommission: json["bonus_commission"],
        expireMailSent: json["expire_mail_sent"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plan_id": planId,
        "user_id": userId,
        "total_day": totalDay,
        "expire_at": expireAt?.toIso8601String(),
        "started_at": startedAt?.toIso8601String(),
        "status_id": statusId,
        "is_active": isActive,
        "is_lifetime": isLifetime,
        "payment_method": paymentMethod,
        "payment_details": paymentDetails,
        "total": total,
        "bonus_commission": bonusCommission,
        "expire_mail_sent": expireMailSent,
        "created_at": createdAt?.toIso8601String(),
      };
}

class UserTotals {
  num? clickLocalstoreTotal;
  dynamic clickLocalstoreCommission;
  num? saleLocalstoreTotal;
  num? saleLocalstoreCommission;
  num? saleLocalstoreCount;
  num? clickExternalTotal;
  String? clickExternalCommission;
  dynamic orderExternalTotal;
  String? orderExternalCount;
  dynamic orderExternalCommission;
  num? clickActionTotal;
  String? clickActionCommission;
  num? vendorClickLocalstoreTotal;
  dynamic vendorClickLocalstoreCommission;
  dynamic vendorClickLocalstoreCommissionPay;
  num? vendorClickExternalTotal;
  num? vendorClickExternalCommission;
  num? vendorClickExternalCommissionPay;
  num? vendorActionExternalTotal;
  num? vendorActionExternalCommission;
  num? vendorActionExternalCommissionPay;
  dynamic vendorOrderExternalCommissionPay;
  String? vendorOrderExternalCount;
  dynamic vendorOrderExternalTotal;
  num? clickFormTotal;
  dynamic clickFormCommission;
  num? walletUnpaidAmount;
  num? walletUnpaidCount;
  num? totalClicksCount;
  num? totalClicksCommission;
  String? userBalance;

  UserTotals({
    this.clickLocalstoreTotal,
    this.clickLocalstoreCommission,
    this.saleLocalstoreTotal,
    this.saleLocalstoreCommission,
    this.saleLocalstoreCount,
    this.clickExternalTotal,
    this.clickExternalCommission,
    this.orderExternalTotal,
    this.orderExternalCount,
    this.orderExternalCommission,
    this.clickActionTotal,
    this.clickActionCommission,
    this.vendorClickLocalstoreTotal,
    this.vendorClickLocalstoreCommission,
    this.vendorClickLocalstoreCommissionPay,
    this.vendorClickExternalTotal,
    this.vendorClickExternalCommission,
    this.vendorClickExternalCommissionPay,
    this.vendorActionExternalTotal,
    this.vendorActionExternalCommission,
    this.vendorActionExternalCommissionPay,
    this.vendorOrderExternalCommissionPay,
    this.vendorOrderExternalCount,
    this.vendorOrderExternalTotal,
    this.clickFormTotal,
    this.clickFormCommission,
    this.walletUnpaidAmount,
    this.walletUnpaidCount,
    this.totalClicksCount,
    this.totalClicksCommission,
    this.userBalance,
  });

  factory UserTotals.fromJson(Map<String, dynamic> json) => UserTotals(
        clickLocalstoreTotal: json["click_localstore_total"],
        clickLocalstoreCommission: json["click_localstore_commission"],
        saleLocalstoreTotal: json["sale_localstore_total"],
        saleLocalstoreCommission: json["sale_localstore_commission"],
        saleLocalstoreCount: json["sale_localstore_count"],
        clickExternalTotal: json["click_external_total"],
        clickExternalCommission: json["click_external_commission"],
        orderExternalTotal: json["order_external_total"],
        orderExternalCount: json["order_external_count"],
        orderExternalCommission: json["order_external_commission"],
        clickActionTotal: json["click_action_total"],
        clickActionCommission: json["click_action_commission"],
        vendorClickLocalstoreTotal: json["vendor_click_localstore_total"],
        vendorClickLocalstoreCommission:
            json["vendor_click_localstore_commission"],
        vendorClickLocalstoreCommissionPay:
            json["vendor_click_localstore_commission_pay"],
        vendorClickExternalTotal: json["vendor_click_external_total"],
        vendorClickExternalCommission: json["vendor_click_external_commission"],
        vendorClickExternalCommissionPay:
            json["vendor_click_external_commission_pay"],
        vendorActionExternalTotal: json["vendor_action_external_total"],
        vendorActionExternalCommission:
            json["vendor_action_external_commission"],
        vendorActionExternalCommissionPay:
            json["vendor_action_external_commission_pay"],
        vendorOrderExternalCommissionPay:
            json["vendor_order_external_commission_pay"],
        vendorOrderExternalCount: json["vendor_order_external_count"],
        vendorOrderExternalTotal: json["vendor_order_external_total"],
        clickFormTotal: json["click_form_total"],
        clickFormCommission: json["click_form_commission"],
        walletUnpaidAmount: json["wallet_unpaid_amount"],
        walletUnpaidCount: json["wallet_unpaid_count"],
        totalClicksCount: json["total_clicks_count"],
        totalClicksCommission: json["total_clicks_commission"],
        userBalance: json["user_balance"],
      );

  Map<String, dynamic> toJson() => {
        "click_localstore_total": clickLocalstoreTotal,
        "click_localstore_commission": clickLocalstoreCommission,
        "sale_localstore_total": saleLocalstoreTotal,
        "sale_localstore_commission": saleLocalstoreCommission,
        "sale_localstore_count": saleLocalstoreCount,
        "click_external_total": clickExternalTotal,
        "click_external_commission": clickExternalCommission,
        "order_external_total": orderExternalTotal,
        "order_external_count": orderExternalCount,
        "order_external_commission": orderExternalCommission,
        "click_action_total": clickActionTotal,
        "click_action_commission": clickActionCommission,
        "vendor_click_localstore_total": vendorClickLocalstoreTotal,
        "vendor_click_localstore_commission": vendorClickLocalstoreCommission,
        "vendor_click_localstore_commission_pay":
            vendorClickLocalstoreCommissionPay,
        "vendor_click_external_total": vendorClickExternalTotal,
        "vendor_click_external_commission": vendorClickExternalCommission,
        "vendor_click_external_commission_pay":
            vendorClickExternalCommissionPay,
        "vendor_action_external_total": vendorActionExternalTotal,
        "vendor_action_external_commission": vendorActionExternalCommission,
        "vendor_action_external_commission_pay":
            vendorActionExternalCommissionPay,
        "vendor_order_external_commission_pay":
            vendorOrderExternalCommissionPay,
        "vendor_order_external_count": vendorOrderExternalCount,
        "vendor_order_external_total": vendorOrderExternalTotal,
        "click_form_total": clickFormTotal,
        "click_form_commission": clickFormCommission,
        "wallet_unpaid_amount": walletUnpaidAmount,
        "wallet_unpaid_count": walletUnpaidCount,
        "total_clicks_count": totalClicksCount,
        "total_clicks_commission": totalClicksCommission,
        "user_balance": userBalance,
      };
}
