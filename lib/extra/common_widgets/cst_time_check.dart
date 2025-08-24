import 'package:intl/intl.dart';

cstCurrentTimeCheck() {
  DateTime utcNow = DateTime.now().toUtc();
  Duration cstOffset = const Duration(hours: -6);
  DateTime cstTime = utcNow.add(cstOffset);
  return cstTime;
}


posTimeCheckValues({String? startTime, String? endTime, String? timeZone, String? Date}) {
  bool shopTime = false;
  if (timeZone == 'CST') {
    dynamic currentimeValues = cstCurrentTimeCheck();

    String formattedCstTime = DateFormat('EEEE').format(currentimeValues);
    String formatCstTime = DateFormat('yyyy-MM-dd').format(currentimeValues);
    DateTime shopOpenTime = DateFormat("yyyy-MM-dd hh:mm").parse("$formatCstTime $startTime");
    DateTime shopCloseTime = DateFormat("yyyy-MM-dd hh:mm").parse("$formatCstTime $endTime");
    // DateTime shopCloseTime = DateTime.parse("$formatCstTime $endTime");
    // print('----');
    // print(shopOpenTime);

    if (Date == formattedCstTime) {
      if (currentimeValues.isAfter(shopOpenTime) &&
          currentimeValues.isBefore(shopCloseTime)) {
        shopTime = true;
      } else {
        shopTime = false;
      }
    }
  }

  return shopTime;
}


String getDifference(DateTime date){
  Duration duration =  DateTime.now().difference(date);
  String differenceInMinutes = (duration.inDays).toString();
  return differenceInMinutes;
}
//yyyy-MM-dd
