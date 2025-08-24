import 'dart:convert';

import 'package:dip_menu/core/static/stactic_values.dart';
import 'package:encrypt/encrypt.dart';

class Encrypt{

 static encryptingData(Map values){
    final plainText =jsonEncode(values);
    final key = Key.fromUtf8('7v9y/B?E(H+MbQeThHmZq4t7w!z%C&F)');
    final iv1= IV.fromUtf8(NameValues.keyValues.substring(0,16));
    final encrypter =  Encrypter(AES(key, mode:AESMode.ctr));
    final encrypted = encrypter.encrypt(plainText, iv: iv1);
    String encryptedBase64 = encrypted.base64;
    return encryptedBase64;
  }

  static decryptionData(dynamic values){
    final key = Key.fromUtf8('7v9y/B?E(H+MbQeThHmZq4t7w!z%C&F)');
    final iv= IV.fromUtf8(NameValues.keyValues.substring(0,16));
    final decrypter = Encrypter(AES(key, mode:AESMode.ctr, padding: null));
    final decrypted = decrypter.decryptBytes(Encrypted.fromBase64(values), iv: iv);
    final decryptedData = utf8.decode(decrypted);
    return decryptedData;
  }
}