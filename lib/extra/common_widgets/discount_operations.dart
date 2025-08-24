import '../../domain/local_handler/Local_handler.dart';

productSlashValues(dynamic  values){
  dynamic salesTax=SharedPrefs.instance.getString('salesTax');
  return values*(1-int.parse(salesTax)/100);
}

productDiscountPrize(dynamic values){
 dynamic discount= SharedPrefs.instance.getString('discount');
  return values*(1-int.parse(discount)/100);
}


cartDiscountPrize(dynamic totalValues){
  dynamic discount= SharedPrefs.instance.getString('discount');
  var totalPrize= 1  -  (1-int.parse(discount)/100);
  dynamic  onlineSavingValues=totalValues*double.parse(totalPrize.toStringAsFixed(2));
  return onlineSavingValues;
}