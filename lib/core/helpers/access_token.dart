import 'package:amazone_clone/core/contants/key.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getAccessToken() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final accessToken = sharedPreferences.getString(ConstantKeys.accesToken);
  return accessToken;
}
