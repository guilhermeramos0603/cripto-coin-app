import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;
  Map<String, String> locale = {
    "locale": "en_US",
    "name": "\$",
  };

  AppSettings() {
    _startSettings();
  }

  setLocale(String local, String name) async {
    await _prefs.setString("local", local);
    await _prefs.setString("name", name);

    await _readLocale();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readLocale() {
    final local = _prefs.getString('local') ?? "en_US";
    final name = _prefs.getString('name') ?? "\$";

    locale = {
      "locale": local,
      "name": name,
    };
  }
}
