import 'package:dip_menu/core/config/theme.dart';
import 'package:dip_menu/presentation/logic/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PosBottomSheetWidget extends StatelessWidget {
  final HomeController posController = Get.find();

  String todayDt = DateFormat('EEEE').format(DateTime.now());
  String formattedDate = DateFormat('kk:mm').format(DateTime.now());

  PosBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) =>  //todayDt == posController.posMessageList[0].schDay ?
  Container(
    //width: 200,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20))
    ),
    child:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: [
            Icon(Icons.warning_amber,size: 20,color: mainColor,),
            const SizedBox(width: 10),
            /*Expanded(
              child: Text( posController.posMessageList[0].endTime!,   //todayDt+'pos msg title',
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),*/
            Expanded(
              child: Text( posController.posMessageList[0].message!,   //todayDt+'pos msg title',
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
          ],

        ),
        const SizedBox(height: 4),
      /*  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('No'),
              onPressed: onClickedNo,
            ),
            const SizedBox(width: 32),
            TextButton(
              child: Text('Yes'),
              onPressed: onClickedYes,
            ),
          ],
        ),*/
      ],
    )

  )
      ;//:
  //Container(height: 0);
}