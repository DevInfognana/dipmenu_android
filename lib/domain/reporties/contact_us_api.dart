
import '../entities/crud_operation.dart';
import '../provider/http_request.dart';

class ContactUsServices {
  static contactUsRequest() async {
    var url = '${BaseAPI.api}/website/contactus';
    var response = await Crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }
}