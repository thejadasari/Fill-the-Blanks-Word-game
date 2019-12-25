import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkipWordNotifier extends ChangeNotifier {
  SkipWordNotifier() {
    getSkipsLeft();
  }

  int _skipsLeft;

  int get skipsLeft {
    if (_skipsLeft == null) {
      getSkipsLeft();
      return 10;
    }
    return _skipsLeft;
  }

  void getSkipsLeft() {
    SharedPreferences.getInstance().then((SharedPreferences pref) {
      String _lastDate = pref.getString('lastDateSkipsUpdated');
      var today = DateTime.now();
      int todayInMilliSecs = new DateTime.now().millisecondsSinceEpoch;
      if (_lastDate == null) {
        _skipsLeft = 10;
        // Update date to today
        pref.setString('lastDateSkipsUpdated', todayInMilliSecs.toString());
        pref.setInt('skipsLeftForToday', 10);
      } else {
        var lastDate =
            new DateTime.fromMillisecondsSinceEpoch(int.parse(_lastDate));
        var dateDiff = new DateTime(today.year, today.month, today.day)
            .difference(
                new DateTime(lastDate.year, lastDate.month, lastDate.day))
            .inDays;
        if (dateDiff > 0) {
          _skipsLeft = 10;
          // Update date to today
          pref.setString('lastDateSkipsUpdated', todayInMilliSecs.toString());
          pref.setInt('skipsLeftForToday', 10);
        } else {
          _skipsLeft = pref.getInt('skipsLeftForToday');
        }
      }
      notifyListeners();
    });
  }

  updateSkipsLeft(skipsLeft) async {
    _skipsLeft = skipsLeft;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('skipsLeftForToday', skipsLeft);
  }
}
