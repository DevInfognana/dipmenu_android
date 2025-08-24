// "https://testpayments.worldnettps.com/merchant/api/v1"

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dip_menu/domain/local_handler/Local_handler.dart';
import 'package:dip_menu/domain/provider/http_request.dart';

import '../../core/static/stactic_values.dart';
import '../../data/model/payment_model.dart';

class PaymentApi {
  String testPaymentAPi =
      "https://testpayments.worldnettps.com/merchant/api/v1";
  String authentication =
      "https://testpayments.worldnettps.com/merchant/api/v1/account/authenticate";
  String cardVerification =
      'https://testpayments.worldnettps.com/merchant/api/v1/customer/cards/verify';
  String cardPayment =
      'https://testpayments.worldnettps.com/merchant/api/v1/transaction/payments';
  dynamic autthenticationToken;
  dynamic paymentResponse = '';

  Future paymentAuthentication() async {
    var url = authentication;
    // print('---->$url');
    var response = await Dio().get(
      url,
      options: Options(headers: {
        "Authorization": 'Basic $NameValues.authToken',
      }),
    );

    // print('wecome${response.statusCode}');
    if (response.statusCode == 200) {
      // print('token${response.data['token']}');

      return response.data['token'];
    } else {
      throw Exception('not authication');
    }
  }

  Future cardVerification1(
      {required String? cardNumber,
      required String expirydate,
      required int Cvv,
      required String? token}) async {
    var url = cardVerification;
    // print('---->$url');

    var cardInput = jsonEncode({
      "terminal": NameValues.terminalValues,
      "customerAccount": {
        "payloadType": "KEYED",
        "accountType": "CHECKING",
        "cardDetails": {
          "dataFormat": "PLAIN_TEXT",
          "cardNumber": cardNumber,
          "expiryDate": expirydate,
          "cvv": Cvv
        }
      }
    });
    // print('auth--8->$token');
    var response = await Dio().post(
      url,
      data: cardInput,
      options: Options(headers: {
        "Authorization": 'Bearer $token',
        'Content-Type': 'application/json',
      }),
    );
    // print(response);

    if (response.statusCode == 200) {
      // print(response);

      return response;
    } else {
      throw Exception('not valid Card');
    }
  }

  Future creatPayment(
      {required String? cardNumber1,
      required String expirydate1,
      required int cvv1,
      required int ordernumber,
      String? payment}) async {
    var url = BaseAPI.paymentAPI;
    var cardInput = jsonEncode({
      "payload": {
        "channel": "WEB",
        "terminal": NameValues.terminalValues,
        "order": {
          "orderId": ordernumber,
          "description": "my values order",
          "currency": "USD",
          "totalAmount": payment,
          "orderBreakdown": {"subtotalAmount": payment}
        },
        "customerAccount": {
          "payloadType": "KEYED",
          "accountType": "CHECKING",
          "cardDetails": {
            "dataFormat": "PLAIN_TEXT",
            "cardNumber": cardNumber1,
            "cvv": cvv1,
            "expiryDate": expirydate1
          }
        },
        "autoCapture": true,
        "processAsSale": false
      }
    });
    var response = await Dio().post(
      url,
      data: cardInput,
      options: Options(headers: {
        'x-access-token': SharedPrefs.instance.getString('token'),
        'Content-Type': 'application/json',
      }),
    );

    return response.statusCode;
    /*  if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {

    }*/
  }

  Future paymentOrder(
      {required String tranctionId,
      required String? totalamount,
      required String? type,
      required String Subtotal,
      required int taxPercent,
      required String taxamount,
      required String cardStatus,
      required int OrderNumber,
      required int orderMode,
      required String redeem_points,
      required String gift_card,
      required String gift_points,
      required String? token,
      required String orderMode_details}) async {
    var url = BaseAPI.newOrder;

    var cardInput = jsonEncode({
      "payload": {
        "transactionid": tranctionId,
        "type": type,
        "final_amount": totalamount,
        "order_amount": totalamount,
        "sub_total": Subtotal,
        "tax_percent": taxPercent,
        "tax_amount": taxamount,
        "redeem_points": int.parse(redeem_points),
        "po_number": 1,
        "payment_method": "CARD",
        "payment_status": "Ready",
        "order_status": 1,
        "print_status": 0,
        "status": 1,
        "gift_card": gift_card,
        "gift_point": gift_points,
        "refund": 0,
        "order_response": paymentResponse.toString(),
        "order_number": OrderNumber,
        "order_mode": orderMode,
        "orderMode_details": orderMode_details
      }
    });
    // print(cardInput);

    var response = await Dio().post(
      url,
      data: cardInput,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token'),
      }),
    );
    // print(response);
    int? statusCode = response.statusCode;

    if (statusCode == 200) {
      var user = PaymentModel.fromJson(response.data);
      // print(user);
      return user.orderId;
    } else {
      throw Exception('not valid progresss');
    }
  }

  Future cardtype(String? cardNumber) async {
    var url = BaseAPI.checkrecentcard;
    var cardtype = jsonEncode({
      "payload": {"id": cardNumber}
    });
    // print('---->$cardtype');
    var response = await Dio().post(
      url,
      data: cardtype,
      options: Options(headers: {
        'x-access-token': SharedPrefs.instance.getString('token'),
      }),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('not authication');
    }
  }

  Future createPdf(String? cardNumber) async {
    var url = '${BaseAPI.createPdf}$cardNumber';
    // print(url);

    var response = await Dio().get(url,
        options: Options(headers: {
          'x-access-token': SharedPrefs.instance.getString('token'),
        }));
// print(SharedPrefs.instance.getString('token'));
//     print(response);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('not authication');
    }
  }

  Future updatefailureOrder(
      {int? orderNumber,
      String? paymentUniqueRefernceId,
      String? paymentMessage,
      var responseValues,
      int? caseValues}) async {
    var url = BaseAPI.updateOrder;
    var failure = jsonEncode({
      "payload": {
        "order_number": orderNumber,
        "order_status": 3,
        "status_message": paymentMessage
      }
    });
    // print(BaseAPI.updateOrder);
    // print(failure);
    var response = await Dio().post(
      url,
      data: failure,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token'),
      }),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('not authication');
    }
  }

  Future updatesucessOrder(
      {int? orderNumber,
      String? paymentUniqueRefernceId,
      String? paymentMessage,
      var responseValues,
      int? caseValues}) async {
    var url = BaseAPI.updateOrder;

    var success = jsonEncode({
      "payload": {
        "transactionid": paymentUniqueRefernceId,
        "type": "SALE",
        "order_response": "$responseValues",
        "order_number": orderNumber,
        "order_status": 4,
        "status_message": "Payment Success"
      }
    });
    // print(BaseAPI.updateOrder);
    // print(success);

    var response = await Dio().post(
      url,
      data: success,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'x-access-token': SharedPrefs.instance.getString('token'),
      }),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('not authication');
    }
  }

  Future validateMobileToken({String? tempToken}) async {
    var url = BaseAPI.validateMobileToken;

    var success = jsonEncode({
      "userId": SharedPrefs.instance.getString('user_id'),
      "mobileToken": tempToken
    });
    // print(url);
    // print(success);

    var response = await Dio().post(url,
        data: success,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'x-access-token': SharedPrefs.instance.getString('token')
        }));

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('not authication');
    }
  }

  Future recentOrderDetails({String? orderId}) async {
    var url = BaseAPI.recentOrder;
    var success = jsonEncode({
      "postData": {"id": orderId ?? 0}
    });
    var response = await Dio().post(url,
        data: success,
        options: Options(headers: {
          'x-access-token': SharedPrefs.instance.getString('token')
        }));
// print(response);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('not authication');
    }
  }

  Future mobileGiftCardCheck({String? temptoken}) async {
    var url = BaseAPI.mobileGiftCardCheck;
    var success = jsonEncode(
      {"userToken": temptoken ?? 0});
    // print(url);
    // print(success);
    // print(SharedPrefs.instance.getString('token'));
    var response = await Dio().post(url,
        data: success,
        options: Options(headers: {
          'x-access-token': SharedPrefs.instance.getString('token')
        }));

    // print(response);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('not authication');
    }
  }


  Future mobileWalletCheck({String? temptoken}) async {
    var url = BaseAPI.mobileWalletCheck;
    var success = jsonEncode(
        {"userToken": temptoken ?? 0});
    // print(url);
    var response = await Dio().post(url,
        data: success,
        options: Options(headers: {
          'x-access-token': SharedPrefs.instance.getString('token')
        }));
    // print(response);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('not authication');
    }
  }
}
