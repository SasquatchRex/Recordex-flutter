import 'package:hive/hive.dart';
import 'dart:convert';
import 'dart:typed_data';
// import 'package:crypto/crypto.dart';



Future<void> saveAuthTokens({
  required String accessToken,

}) async {
  final box = await Hive.openBox('authBox');
  await box.put('access_token', accessToken);

}


Future<Map<String, String?>> getAuthTokens() async {
  final box = await Hive.openBox('authBox');
  return {
    'accessToken': box.get('access_token'),

  };
}