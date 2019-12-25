import 'package:blanks/database/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blanks/models/word.dart';

class GameModeNotifier extends ChangeNotifier {
  GameModeNotifier() {
    getMode();
  }

  static final holesObj = {
    "easy": [2, 3],
    "medium": [4, 5],
    "hard": [6, 7, 8],
    "pro": [6, 7, 8]
  };

  static getLevelBonus(_gameMode) {
    if (_gameMode == 'easy') {
      return 1;
    }
    if (_gameMode == 'medium') {
      return 2;
    }
    if (_gameMode == 'hard') {
      return 3;
    }
    if (_gameMode == 'pro') {
      return 4;
    }
  }

  static WordModel updateWordModel(_gameMode, WordModel wordModel){
    if (_gameMode == 'easy') {
      wordModel.usedInEasy = true;
    }else if (_gameMode == 'medium') {
      wordModel.usedInMedium = true;
    }else if (_gameMode == 'hard') {
      wordModel.usedInHard = true;
    }else if (_gameMode == 'pro') {
      wordModel.usedInPro = true;
    }
    return wordModel;
  }

  static Map getWhereCondition(_gameMode){
    if (_gameMode == 'easy') {
      return {
        'column' : AppDataBase.usedInEasy,
        'min-length' : 5,
        'max-length' : 8
      };
    }
    if (_gameMode == 'medium') {
      return {
        'column' : AppDataBase.usedInMedium,
        'min-length' : 8,
        'max-length' : 11
      };
    }
    if (_gameMode == 'hard') {
      return {
        'column' : AppDataBase.usedInHard,
        'min-length' : 10,
        'max-length' : 20
      };
    }
    if (_gameMode == 'pro') {
      return {
        'column' : AppDataBase.usedInPro,
        'min-length' : 10,
        'max-length' : 20
      };
    }
  }

  List<Map<String, Object>> _options = [
    {
      'mode': 'easy',
      'title': 'Easy',
      'subTitle': '2 or 3 missing characters in a word',
      'selected': false
    },
    {
      'mode': 'medium',
      'title': 'Medium',
      'subTitle': '4 or 5 missing characters in a word',
      'selected': false
    },
    {
      'mode': 'hard',
      'title': 'Hard',
      'subTitle': '6 to 8 missing characters in a word',
      'selected': false
    },
    // {
    //   'mode': 'pro',
    //   'title': 'Pro',
    //   'subTitle': 'Play without Hints',
    //   'selected': false
    // }
  ];

  String _mode;

  String get mode {
    if (_mode == null) {
      getMode();
      return 'easy';
    }
    return _mode;
  }

  List<Map<String, Object>> get options {
    List<Map<String, Object>> newOptions = [];
    for (var option in _options) {
      option['selected'] = option['mode'] == mode;
      newOptions.add(option);
    }
    return newOptions;
  }

  void getMode() {
    SharedPreferences.getInstance().then((SharedPreferences pref) {
      String __mode = pref.getString('mode');
      if (__mode == null) {
        _mode = 'easy';
        updateGameMode(_mode);
      } else {
        _mode = __mode;
        notifyListeners();
      }
    });
  }

  updateGameMode(selectedMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("mode", selectedMode);
    _mode = selectedMode;
    notifyListeners();
  }
}
