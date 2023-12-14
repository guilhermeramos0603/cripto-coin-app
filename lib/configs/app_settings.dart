import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  late Box box;
  Map<String, String> locale = {
    "locale": "en_US",
    "name": "\$",
  };

  AppSettings() {
    _startSettings();
  }

  setLocale(String local, String name) async {
    await box.put("local", local);
    await box.put("name", name);

    await _readLocale();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    box = await Hive.openBox('preferences');
  }

  _readLocale() {
    final local = box.get('local') ?? "en_US";
    final name = box.get('name') ?? "\$";

    locale = {
      "locale": local,
      "name": name,
    };
  }
}
