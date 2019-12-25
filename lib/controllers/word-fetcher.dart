import 'dart:math';

import 'package:blanks/database/database.dart';
import 'package:blanks/models/word.dart';

class WordFetcher {
  static final WordFetcher _singleton = new WordFetcher._internal();

  factory WordFetcher() {
    return _singleton;
  }

  WordFetcher._internal();

  List<WordModel> _words = [];
  String _prevMode;

  AppDataBase _databaseService = AppDataBase();

  Future<WordModel> getWord(String mode) async {
    if (_words.length == 0 || _prevMode != mode) {
      _prevMode = mode;
      _words = await _databaseService.getWords(mode);
    }
    // int index = Random().nextInt(_words.length);
    WordModel word = _words.elementAt(0);
    _words.removeAt(0);
    return word;
  }
}
