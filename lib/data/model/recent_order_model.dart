class RecentOrderData {
  bool? status;
  String? message;
  List<RecentOrderValue>? data;

  RecentOrderData({this.status, this.message, this.data});

  RecentOrderData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RecentOrderValue>[];
      json['data'].forEach((v) {
        data!.add(RecentOrderValue.fromJson(v));
      });
    }
  }

}

class RecentOrderValue {
  int? id;
  String? transactionid;
  String? type;
  int? customerId;
  String? orderNumber;
  String? orderTotal;
  String? orderAmount;
  String? subTotal;
  String? taxPercent;
  String? taxAmount;
  String? redeemPoints;
  String? paymentMethod;
  String? paymentStatus;
  int? orderStatus;
  String? status;
  int? trash;
  dynamic giftCard;
  dynamic giftPoint;
  dynamic gpstrack;
  String? statusMessage;
  String? orderMode;
  String? orderModeDetails;
  String? createdAt;
  List<OrderDetails>? orderDetails;
  Customer? customer;

  RecentOrderValue(
      {this.id,
        this.transactionid,
        this.type,
        this.customerId,
        this.orderNumber,
        this.orderTotal,
        this.orderAmount,
        this.subTotal,
        this.taxPercent,
        this.taxAmount,
        this.redeemPoints,
        this.paymentMethod,
        this.paymentStatus,
        this.orderStatus,
        this.status,
        this.trash,
        this.giftCard,
        this.giftPoint,
        this.statusMessage,
        this.orderMode,
        this.orderModeDetails,
        this.orderDetails,
        this.createdAt,
        this.customer,this.gpstrack});

  RecentOrderValue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionid = json['transactionid'];
    type = json['type'];
    customerId = json['customer_id'];
    orderNumber = json['order_number'];
    orderTotal = json['order_total'];
    orderAmount = json['order_amount'];
    subTotal = json['sub_total'];
    taxPercent = json['tax_percent'];
    taxAmount = json['tax_amount'];
    redeemPoints = json['redeem_points'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    status = json['status'];
    trash = json['trash'];
    giftCard = json['gift_card'];
    giftPoint = json['gift_point'];
    statusMessage = json['status_message'];
    orderMode = json['order_mode'];
    orderModeDetails = json['orderMode_details'];
    gpstrack=json['gps_track'];
    createdAt = json['created_at'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }
}

class OrderDetails {
  int? id;
  int? orderId;
  int? categoryId;
  String? categoryName;
  int? subcategoryId;
  String? subcategoryName;
  int? productId;
  String? productName;
  String? productCode;
  String? productPrice;
  String? productImage;
  String? productDescription;
  int? defaultCustom;
  int? reward;
  int? itemsizeId;
  String? itemsizeName;
  dynamic kitchenCodeId;
  dynamic kitchenCode;
  int? quantity;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  OrderDetails(
      {this.id,
        this.orderId,
        this.categoryId,
        this.categoryName,
        this.subcategoryId,
        this.subcategoryName,
        this.productId,
        this.productName,
        this.productCode,
        this.productPrice,
        this.productImage,
        this.productDescription,
        this.defaultCustom,
        this.reward,
        this.itemsizeId,
        this.itemsizeName,
        this.kitchenCodeId,
        this.kitchenCode,
        this.quantity,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subcategoryId = json['subcategory_id'];
    subcategoryName = json['subcategory_name'];
    productId = json['product_id'];
    productName = json['product_name'];
    productCode = json['product_code'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    productDescription = json['product_description'];
    defaultCustom = json['default_custom'];
    reward = json['reward'];
    itemsizeId = json['itemsize_id'];
    itemsizeName = json['itemsize_name'];
    kitchenCodeId = json['kitchen_code_id'];
    kitchenCode = json['kitchen_code'];
    quantity = json['quantity'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Customer {
  int? id;
  int? roleId;
  String? firstName;
  String? lastName;
  String? mobile;
  String? email;
  String? location;
  String? password;
  String? profileImageurl;
  int? rewardPoints;
  int? status;
  String? driveThruDetails;
  int? trash;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.id,
        this.roleId,
        this.firstName,
        this.lastName,
        this.mobile,
        this.email,
        this.location,
        this.password,
        this.profileImageurl,
        this.rewardPoints,
        this.status,
        this.driveThruDetails,
        this.trash,
        this.createdAt,
        this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
    email = json['email'];
    location = json['location'];
    password = json['password'];
    profileImageurl = json['profile_imageurl'];
    rewardPoints = json['reward_points'];
    status = json['status'];
    driveThruDetails = json['driveThru_details'];
    trash = json['trash'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
