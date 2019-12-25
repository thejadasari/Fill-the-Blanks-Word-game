import 'dart:math';

import 'package:blanks/change-notifiers/game-mode-notifier.dart';
import 'package:blanks/controllers/word-fetcher.dart';
import 'package:blanks/models/word.dart';

class WordProcessor {
  static final WordProcessor _singleton = new WordProcessor._internal();

  factory WordProcessor() {
    return _singleton;
  }

  WordProcessor._internal();
  var fetcher = WordFetcher();

  Map<String, dynamic> activeWord = {};

  List<int> getHoles(mode) {
    return GameModeNotifier.holesObj[mode];
  }

  String _prevMode;

  clearActiveWord(){
    activeWord = {};
  }

  Future<Map> processWord(String mode, bool getActiveWord) async {
    if (getActiveWord && activeWord['word'] != null && _prevMode == mode) {
      return {...activeWord};
    }
    _prevMode = mode;
    WordModel wordModel = await fetcher.getWord(mode);
    String _word = wordModel.word;
    List holesList = getHoles(mode);
    int holes = holesList[Random().nextInt(holesList.length)];
    // If holes length is greater then word length then switch
    holes = _word.length <= holes ? _word.length - 2 : holes;
    List<int> pickedChars = [];
    while (holes > 0) {
      int randomChar = Random().nextInt(_word.length);
      if (pickedChars.indexOf(randomChar) == -1) {
        pickedChars.add(randomChar);
        holes--;
      }
    }

    List<String> chars = _word.split('');
    List _displayedChars = [];
    for (var i = 0; i < chars.length; i++) {
      var obj = {
        "char": chars[i],
        "hidden": false,
      };
      if (pickedChars.indexOf(i) != -1) {
        obj = {
          "char": "",
          "hidden": true,
        };
      }
      _displayedChars.add(obj);
    }
    List _dragables = [];
    for (int position in pickedChars) {
      _dragables.add({
        "char": chars[position],
        "hide": false,
      });
    }
    // Store Current word
    activeWord = {
      'word': _word,
      'displayedChars': _displayedChars,
      'dragables': _dragables,
      'wordModel': wordModel
    };

    return {
      'word': _word,
      'displayedChars': _displayedChars,
      'dragables': _dragables,
      'wordModel': wordModel
    };
  }
}
