import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefence {
  static late SharedPreferences _preferences;

  static const _keyUsername = 'email';
  static const _keygender = 'gender';
  static const _keyid = 'id';
  static const _firstName = 'name';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);

  static String getUsername() => _preferences.getString(_keyUsername);

  static Future setid(String id) async =>
      await _preferences.setString(_keyid, id);

  static String getid() => _preferences.getString(_keyid);

  static Future setgender(String gender) async =>
      await _preferences.setString(_keygender, gender);

  static String getgender() => _preferences.getString(_keygender);

  static Future setFirstname(String name) async =>
      await _preferences.setString(_firstName, name);

  static String getFirstname() => _preferences.getString(_firstName);
}
