class MyNetWorkModel {
  bool? status;
  String? message;
  Data? data;

  MyNetWorkModel({
    this.status,
    this.message,
    this.data,
  });

  factory MyNetWorkModel.fromJson(Map<String, dynamic> json) => MyNetWorkModel(
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
  List<Userslist>? userslist;
  ReferTotal? referTotal;
  List<ReferredUsersTree>? referredUsersTree;

  Data({
    this.userslist,
    this.referTotal,
    this.referredUsersTree,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userslist: json["userslist"] == null
            ? []
            : List<Userslist>.from(
                json["userslist"]!.map((x) => Userslist.fromJson(x))),
        referTotal: json["refer_total"] == null
            ? null
            : ReferTotal.fromJson(json["refer_total"]),
        referredUsersTree: json["referred_users_tree"] == null
            ? []
            : List<ReferredUsersTree>.from(json["referred_users_tree"]!
                .map((x) => ReferredUsersTree.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userslist": userslist == null
            ? []
            : List<dynamic>.from(userslist!.map((x) => x.toJson())),
        "refer_total": referTotal?.toJson(),
        "referred_users_tree": referredUsersTree == null
            ? []
            : List<dynamic>.from(referredUsersTree!.map((x) => x.toJson())),
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
  int? clicks;

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

class ReferredUsersTree {
  String? title;
  String? phone;
  String? email;
  int? click;
  int? externalClick;
  int? formClick;
  int? affClick;
  String? clickCommission;
  int? externalActionClick;
  String? actionClickCommission;
  String? amountExternalSaleAmount;
  String? saleCommission;
  String? paidCommition;
  String? unpaidCommition;
  String? inRequestCommiton;
  String? allCommition;
  List<ReferredUsersTree>? children;

  ReferredUsersTree({
    this.title,
    this.phone,
    this.email,
    this.click,
    this.externalClick,
    this.formClick,
    this.affClick,
    this.clickCommission,
    this.externalActionClick,
    this.actionClickCommission,
    this.amountExternalSaleAmount,
    this.saleCommission,
    this.paidCommition,
    this.unpaidCommition,
    this.inRequestCommiton,
    this.allCommition,
    this.children,
  });

  factory ReferredUsersTree.fromJson(Map<String, dynamic> json) =>
      ReferredUsersTree(
        title: json["title"],
        phone: json["phone"],
        email: json["email"],
        click: json["click"],
        externalClick: json["external_click"],
        formClick: json["form_click"],
        affClick: json["aff_click"],
        clickCommission: json["click_commission"]!,
        externalActionClick: json["external_action_click"],
        actionClickCommission: json["action_click_commission"]!,
        amountExternalSaleAmount: json["amount_external_sale_amount"]!,
        saleCommission: json["sale_commission"]!,
        paidCommition: json["paid_commition"]!,
        unpaidCommition: json["unpaid_commition"]!,
        inRequestCommiton: json["in_request_commiton"]!,
        allCommition: json["all_commition"]!,
        children: json["children"] == null
            ? []
            : List<ReferredUsersTree>.from(
                json["children"]!.map((x) => ReferredUsersTree.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "phone": phone,
        "email": email,
        "click": click,
        "external_click": externalClick,
        "form_click": formClick,
        "aff_click": affClick,
        "click_commission":
            actionClickCommissionValues.reverse[clickCommission],
        "external_action_click": externalActionClick,
        "action_click_commission":
            actionClickCommissionValues.reverse[actionClickCommission],
        "amount_external_sale_amount":
            actionClickCommissionValues.reverse[amountExternalSaleAmount],
        "sale_commission": actionClickCommissionValues.reverse[saleCommission],
        "paid_commition": actionClickCommissionValues.reverse[paidCommition],
        "unpaid_commition":
            actionClickCommissionValues.reverse[unpaidCommition],
        "in_request_commiton":
            actionClickCommissionValues.reverse[inRequestCommiton],
        "all_commition": actionClickCommissionValues.reverse[allCommition],
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}

enum ActionClickCommission { RS0 }

final actionClickCommissionValues =
    EnumValues({"Rs0": ActionClickCommission.RS0});

class Userslist {
  String? name;
  List<Userslist>? children;

  Userslist({
    this.name,
    this.children,
  });

  factory Userslist.fromJson(Map<String, dynamic> json) => Userslist(
        name: json["name"],
        children: json["children"] == null
            ? []
            : List<Userslist>.from(
                json["children"]!.map((x) => Userslist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
