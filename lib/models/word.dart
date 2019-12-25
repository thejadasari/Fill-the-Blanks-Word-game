import 'package:blanks/database/database.dart';
import 'package:flutter/cupertino.dart';

class WordModel {
  String word;
  List<String> synonyms;
  String description;
  String pronunciation;
  bool usedInEasy;
  bool usedInMedium;
  bool usedInHard;
  bool usedInPro;
  int length;

  WordModel(
      {@required this.word,
      @required this.synonyms,
      @required this.description,
      @required this.pronunciation,
      this.usedInEasy = false,
      this.usedInMedium = false,
      this.usedInHard = false,
      this.usedInPro = false}) {
    this.length = this.word.length;
  }

  // Convert a Word Model into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      AppDataBase.word: word,
      AppDataBase.synonyms: synonyms.join(','),
      AppDataBase.description: description,
      AppDataBase.pronunciation: pronunciation,
      AppDataBase.usedInEasy: usedInEasy ? 1 : 0,
      AppDataBase.usedInMedium: usedInMedium ? 1 : 0,
      AppDataBase.usedInHard: usedInHard ? 1 : 0,
      AppDataBase.usedInPro: usedInPro ? 1 : 0,
      AppDataBase.length: word.length
    };
  }

  WordModel.fromJson(Map<String, dynamic> json) {
    this.word = json[AppDataBase.word];
    this.synonyms = json[AppDataBase.synonyms].toString().split(',');
    this.description = json[AppDataBase.description];
    this.pronunciation = json[AppDataBase.pronunciation];
    this.usedInEasy = json[AppDataBase.usedInEasy] == 1;
    this.usedInMedium = json[AppDataBase.usedInMedium] == 1;
    this.usedInHard = json[AppDataBase.usedInHard] == 1;
    this.usedInPro = json[AppDataBase.usedInPro] == 1;
  }
}
