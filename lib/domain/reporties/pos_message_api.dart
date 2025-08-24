import '../entities/crud_operation.dart';
import '../provider/http_request.dart';

class PosMessageServices {
  static posMessageRequest() async {
    var url = '${BaseAPI.api}/website/poslist';

    var response = await Crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }


}