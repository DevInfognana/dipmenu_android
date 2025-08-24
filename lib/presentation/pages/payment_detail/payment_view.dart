import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../core/config/app_textstyle.dart';
import '../../../core/config/theme.dart';
import '../../../domain/provider/http_request.dart';
import '../../logic/controller/payment_detail_controller.dart';

class PaymentListView extends StatefulWidget {
  const PaymentListView({Key? key}) : super(key: key);

  @override
  State<PaymentListView> createState() => _PaymentListViewState();
}

class _PaymentListViewState extends State<PaymentListView> {

  final numberFormat = NumberFormat("#,##0.00", "en_US");
  PaymentDetailController? paymentController;

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ListView.builder(
              itemCount: paymentController!.cardList.length,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: SizedBox(
                    height: 10.h,
                    width: 16.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1.w),
                      child: Image.network(
                        '${BaseAPI.base}/${paymentController?.cardList[index].product!.image}',
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context,
                            Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: mainColor,
                              value:
                              loadingProgress.expectedTotalBytes !=
                                  null
                                  ? loadingProgress
                                  .cumulativeBytesLoaded /
                                  loadingProgress
                                      .expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  title: Text(
                    '${paymentController?.cardList[index].product!.name}',
                    style: TextStore.textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Qty : ${paymentController?.cardList[index].quantity}',
                        style: TextStore.textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${paymentController?.cardList[index].defaultSizeName}',
                        style: TextStore.textTheme.titleLarge!
                            .copyWith(color: Colors.grey),
                      ),
                      Text(
                        '\$ ${numberFormat.format((double.parse(paymentController!.cardList[index].totalCost!) * paymentController!.cardList[index].quantity!))}',
                        style: TextStore.textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
