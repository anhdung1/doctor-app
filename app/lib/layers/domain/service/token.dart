import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt_token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}

Future<void> removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwt_token');
}

Future<void> saveId(int id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('id', id);
}

Future<int?> getId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('id');
}

Future<void> removeId() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('id');
}
