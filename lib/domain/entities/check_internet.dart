import 'dart:io';

// import 'package:dio/dio.dart';

checkInternet() async {
  try {
    var result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}



// Future<double?> checkInternetSpeed() async {
  // final startTime = DateTime.now();
  // final response =  await Dio().get('https://www.google.com/');
  // final endTime = DateTime.now();
  // final duration = endTime.difference(startTime);
  // dynamic value=response.headers["content-length"];
  // final speed = value / duration.inMilliseconds * 1000 / 1048576;
  // 1048576 is the number of bytes in 1 megabyte
  // final contentLength = response.headers.contentLength;
  // print('Content length: $contentLength');
  // return null;
// }