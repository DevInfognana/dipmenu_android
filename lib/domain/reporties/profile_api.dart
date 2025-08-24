import 'package:dio/dio.dart';
import '../entities/crud_operation.dart';
import '../local_handler/Local_handler.dart';
import '../provider/http_request.dart';

class ProfileViewServices {
 /* Future<ProfileData> profileAPi({required String values}) async {
    var url = '${BaseAPI.profileAPI}/$values';
    var response = await Dio().get(
        url,
        options: Options(headers: BaseAPI.headers)
    );
    print('---welcome${response.data}');
    int? statusCode = response.statusCode;
    print('--->$statusCode');
    if (statusCode == 200) {
      ProfileData user = ProfileData.fromJson(response.data);
      return user;
    } else {
      throw Exception('not Login');
    }
  }*/

   profileAPi({required String values}) async {
    var url = '${BaseAPI.profileAPI}/$values';
    // print(url);
    // print(SharedPrefs.instance.getString('token'));

    var response = await Crud.getData(url,options: Options(headers: {
      'x-access-token':
      SharedPrefs.instance.getString('token')
    })
    );
    return response.fold((l) => l, (r) => r);
  }

}