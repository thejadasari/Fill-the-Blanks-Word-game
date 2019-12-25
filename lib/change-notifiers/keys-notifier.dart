import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeysNotifier extends ChangeNotifier {
  KeysNotifier() {
    getKeys();
  }

  int _keys;

  int get keys {
    if (_keys == null) {
      getKeys();
      return 3;
    }
    return _keys;
  }

  void getKeys() {
    SharedPreferences.getInstance().then((SharedPreferences pref) {
      int __keys = pref.getInt('keys');
      if (__keys == null) {
        _keys = 3;
        updateKeysCount(_keys);
      } else {
        _keys = __keys;
        notifyListeners();
      }
    });
  }

  updateKeysCount(newKeys) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("keys", newKeys);
    _keys = newKeys;
    notifyListeners();
  }
}
