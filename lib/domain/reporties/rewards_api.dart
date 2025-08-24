import 'package:dio/dio.dart';

import '../entities/crud_operation.dart';
import '../local_handler/Local_handler.dart';
import '../provider/http_request.dart';

class RewardsViewServices {
/*  Future<ProfileData> profileAPi({required String values}) async {
    var url = '${BaseAPI.profileAPI}/$values';
    var response = await Dio().get(
        url,
        options: Options(headers: BaseAPI.headers)
    );
    int? statusCode = response.statusCode;
    if (statusCode == 200) {
      ProfileData user = ProfileData.fromJson(response.data);
      return user;
    } else {
      throw Exception('not Login');
    }
  }*/

  static viewRewardsRequest() async {
    var url = BaseAPI.rewardProduct;

    var response = await Crud.getData(url,  options: Options(headers: {
      'x-access-token':
      SharedPrefs.instance.getString('token')
    }));
    return response.fold((l) => l, (r) => r);
  }

}


