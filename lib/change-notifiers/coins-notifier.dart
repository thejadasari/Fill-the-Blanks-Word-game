import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinsNotifier extends ChangeNotifier {
  CoinsNotifier() {
    getCoins();
  }

  int _coins;

  int get coins {
    if (_coins == null) {
      getCoins();
      return 100;
    }
    return _coins;
  }

  void getCoins() {
    SharedPreferences.getInstance().then((SharedPreferences pref) {
      int __coins = pref.getInt('coins');
      if (__coins == null) {
        _coins = 100;
        updateCoinCount(_coins);
      } else {
        _coins = __coins;
        notifyListeners();
      }
    });
  }

  get addCoins {
    return (incrementCount){
      updateCoinCount(coins+incrementCount);
    };
  }

  updateCoinCount(newCoins) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("coins", newCoins);
    _coins = newCoins;
    notifyListeners();
  }
}
