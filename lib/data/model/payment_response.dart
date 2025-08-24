class PaymentResponseAPi {
  bool? status;
  String? message;
  Data? data;
  dynamic orderId;

  PaymentResponseAPi({this.status, this.message, this.data, this.orderId});

  PaymentResponseAPi.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    orderId = json['orderId'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   data['orderId'] = this.orderId;
  //   return data;
  // }
}

class Data {
  String? uniqueReference;
  String? terminal;
  Order? order;
/*  CustomerAccount? customerAccount;
  SecurityCheck? securityCheck;
  TransactionResult? transactionResult;
  List<AdditionalDataFields>? additionalDataFields;
  List<Receipts>? receipts;
  List<Links>? links;*/

  Data(
      {this.uniqueReference,
        this.terminal,
        this.order,
      /*  this.customerAccount,
        this.securityCheck,
        this.transactionResult,
        this.additionalDataFields,
        this.receipts,
        this.links*/});

  Data.fromJson(Map<String, dynamic> json) {
    uniqueReference = json['uniqueReference'];
    terminal = json['terminal'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    /*customerAccount = json['customerAccount'] != null
        ? new CustomerAccount.fromJson(json['customerAccount'])
        : null;
    securityCheck = json['securityCheck'] != null
        ? new SecurityCheck.fromJson(json['securityCheck'])
        : null;
    transactionResult = json['transactionResult'] != null
        ? new TransactionResult.fromJson(json['transactionResult'])
        : null;
    if (json['additionalDataFields'] != null) {
      additionalDataFields = <AdditionalDataFields>[];
      json['additionalDataFields'].forEach((v) {
        additionalDataFields!.add(new AdditionalDataFields.fromJson(v));
      });
    }
    if (json['receipts'] != null) {
      receipts = <Receipts>[];
      json['receipts'].forEach((v) {
        receipts!.add(new Receipts.fromJson(v));
      });
    }
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }*/
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['uniqueReference'] = this.uniqueReference;
  //   data['terminal'] = this.terminal;
  //   if (this.order != null) {
  //     data['order'] = this.order!.toJson();
  //   }
  //  /* if (this.customerAccount != null) {
  //     data['customerAccount'] = this.customerAccount!.toJson();
  //   }
  //   if (this.securityCheck != null) {
  //     data['securityCheck'] = this.securityCheck!.toJson();
  //   }
  //   if (this.transactionResult != null) {
  //     data['transactionResult'] = this.transactionResult!.toJson();
  //   }
  //   if (this.additionalDataFields != null) {
  //     data['additionalDataFields'] =
  //         this.additionalDataFields!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.receipts != null) {
  //     data['receipts'] = this.receipts!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.links != null) {
  //     data['links'] = this.links!.map((v) => v.toJson()).toList();
  //   }*/
  //   return data;
  // }
}

class Order {
  String? orderId;
  String? currency;
  dynamic totalAmount;
  OrderBreakdown? orderBreakdown;

  Order({this.orderId, this.currency, this.totalAmount, this.orderBreakdown});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    currency = json['currency'];
    totalAmount = json['totalAmount'];
    orderBreakdown = json['orderBreakdown'] != null
        ? OrderBreakdown.fromJson(json['orderBreakdown'])
        : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['orderId'] = this.orderId;
  //   data['currency'] = this.currency;
  //   data['totalAmount'] = this.totalAmount;
  //   if (this.orderBreakdown != null) {
  //     data['orderBreakdown'] = this.orderBreakdown!.toJson();
  //   }
  //   return data;
  // }
}

class OrderBreakdown {
  dynamic subtotalAmount;
  List<Items>? items;

  OrderBreakdown({this.subtotalAmount, this.items});

  OrderBreakdown.fromJson(Map<String, dynamic> json) {
    subtotalAmount = json['subtotalAmount'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['subtotalAmount'] = this.subtotalAmount;
  //   if (this.items != null) {
  //     data['items'] = this.items!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Items {
  int? unitPrice;
  int? quantity;

  Items({this.unitPrice, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    unitPrice = json['unitPrice'];
    quantity = json['quantity'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['unitPrice'] = this.unitPrice;
  //   data['quantity'] = this.quantity;
  //   return data;
  // }
}

class CustomerAccount {
  String? cardType;
  String? maskedPan;
  String? expiryDate;
  String? entryMethod;

  CustomerAccount(
      {this.cardType, this.maskedPan, this.expiryDate, this.entryMethod});

  CustomerAccount.fromJson(Map<String, dynamic> json) {
    cardType = json['cardType'];
    maskedPan = json['maskedPan'];
    expiryDate = json['expiryDate'];
    entryMethod = json['entryMethod'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['cardType'] = this.cardType;
  //   data['maskedPan'] = this.maskedPan;
  //   data['expiryDate'] = this.expiryDate;
  //   data['entryMethod'] = this.entryMethod;
  //   return data;
  // }
}

class SecurityCheck {
  String? cvvResult;
  String? avsResult;

  SecurityCheck({this.cvvResult, this.avsResult});

  SecurityCheck.fromJson(Map<String, dynamic> json) {
    cvvResult = json['cvvResult'];
    avsResult = json['avsResult'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['cvvResult'] = this.cvvResult;
  //   data['avsResult'] = this.avsResult;
  //   return data;
  // }
}

class TransactionResult {
  String? type;
  String? status;
  String? approvalCode;
  String? dateTime;
  String? currency;
  dynamic authorizedAmount;
  String? resultCode;
  String? resultMessage;

  TransactionResult(
      {this.type,
        this.status,
        this.approvalCode,
        this.dateTime,
        this.currency,
        this.authorizedAmount,
        this.resultCode,
        this.resultMessage});

  TransactionResult.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    status = json['status'];
    approvalCode = json['approvalCode'];
    dateTime = json['dateTime'];
    currency = json['currency'];
    authorizedAmount = json['authorizedAmount'];
    resultCode = json['resultCode'];
    resultMessage = json['resultMessage'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['type'] = this.type;
  //   data['status'] = this.status;
  //   data['approvalCode'] = this.approvalCode;
  //   data['dateTime'] = this.dateTime;
  //   data['currency'] = this.currency;
  //   data['authorizedAmount'] = this.authorizedAmount;
  //   data['resultCode'] = this.resultCode;
  //   data['resultMessage'] = this.resultMessage;
  //   return data;
  // }
}

class AdditionalDataFields {
  String? name;
  String? value;

  AdditionalDataFields({this.name, this.value});

  AdditionalDataFields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['value'] = this.value;
  //   return data;
  // }
}

class Receipts {
  String? copy;
  String? header;
  List<MerchantDetails>? merchantDetails;

  String? footer;

  Receipts(
      {this.copy,
        this.header,
        this.merchantDetails,
        this.footer});

  Receipts.fromJson(Map<String, dynamic> json) {
    copy = json['copy'];
    header = json['header'];
    if (json['merchantDetails'] != null) {
      merchantDetails = <MerchantDetails>[];
      json['merchantDetails'].forEach((v) {
        merchantDetails!.add(MerchantDetails.fromJson(v));
      });
    }

    footer = json['footer'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['copy'] = this.copy;
  //   data['header'] = this.header;
  //   if (this.merchantDetails != null) {
  //     data['merchantDetails'] =
  //         this.merchantDetails!.map((v) => v.toJson()).toList();
  //   }
  //
  //   data['footer'] = this.footer;
  //   return data;
  // }
}

class MerchantDetails {
  int? order;
  String? label;
  String? value;

  MerchantDetails({this.order, this.label, this.value});

  MerchantDetails.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    label = json['label'];
    value = json['value'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['order'] = this.order;
  //   data['label'] = this.label;
  //   data['value'] = this.value;
  //   return data;
  // }
}

class Links {
  String? rel;
  String? method;
  String? href;

  Links({this.rel, this.method, this.href});

  Links.fromJson(Map<String, dynamic> json) {
    rel = json['rel'];
    method = json['method'];
    href = json['href'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['rel'] = this.rel;
  //   data['method'] = this.method;
  //   data['href'] = this.href;
  //   return data;
  // }
}





class Failuremessage {
  bool? status;
  String? message;
  dynamic data;
dynamic orderId;

  Failuremessage({this.status, this.message});

  Failuremessage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   return data;
  // }
}



