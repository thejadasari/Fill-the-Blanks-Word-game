import 'dart:io';

import 'package:blanks/change-notifiers/game-mode-notifier.dart';
import 'package:blanks/data/data.dart';
import 'package:blanks/models/word.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  final databaseName = "words_database.db";
  static const tableName = 'words_table';
  static const word = 'word';
  static const synonyms = 'synonyms';
  static const description = 'description';
  static const pronunciation = 'pronunciation';
  static const usedInEasy = 'usedInEasy';
  static const usedInMedium = 'usedInMedium';
  static const usedInHard = 'usedInHard';
  static const usedInPro = 'usedInPro';
  static const length = 'length';

  static final AppDataBase _singleton = new AppDataBase._internal();

  factory AppDataBase() {
    return _singleton;
  }

  AppDataBase._internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      return initDatabase();
    }
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      // await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> onCreate(Database db, int version) async {
    print("Creating Table");
    final query = '''CREATE TABLE $tableName
    (
      $word TEXT PRIMARY KEY,
      $synonyms TEXT,
      $description TEXT,
      $pronunciation TEXT,
      $usedInEasy BIT NOT NULL,
      $usedInMedium BIT NOT NULL,
      $usedInHard BIT NOT NULL,
      $usedInPro BIT NOT NULL,
      $length INTEGER NOT NULL
    )''';

    await db.execute(query);
  }

  Future<void> saveWordsToDB(Database db) async {
    List words = Data().words;
    print(words.length);

    final List<Map<String, dynamic>> _dbwords = await db.query(tableName);
    print(_dbwords.length);
    if(words.length < _dbwords.length + 20){
      return null;
    }
    for (var _word in words) {
      try {
        WordModel model = WordModel(
          word: _word[word],
          description: _word[description],
          synonyms: _word[synonyms].length == 0 ? ['']: _word[synonyms],
          pronunciation: _word[pronunciation],
          usedInEasy: false,
          usedInMedium: false,
          usedInHard: false,
          usedInPro: false,
        );
        // In this case, Do not replace any previous data.
        await db.insert(
          tableName,
          model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      } catch (e) {
        print(_word[word]);
        print(e);
      }
    }

    // Query the table for all The Words.
    // final List<Map<String, dynamic>> _dbwords = await db.query(tableName);
    // print(_dbwords.length);
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasePath(databaseName);
    _db = await openDatabase(path, version: 1, onCreate: onCreate);
    await saveWordsToDB(_db);
    return _db;
  }

  Future<List<WordModel>> getWords(String mode) async {
    var whereData = GameModeNotifier.getWhereCondition(mode);
    var column = whereData['column'];
    var minLength = whereData['min-length'];
    var maxLength = whereData['max-length'];
    // final List<Map<String, dynamic>> _dbwords = await (await db).query(
    //   tableName,
    //   where: '$column = ? AND length >= ?',
    //   whereArgs: [0, length],
    // );
    // GET WORDS Randomly from Database
    final List<Map<String, dynamic>> _dbwords = await (await db).rawQuery('SELECT * FROM $tableName WHERE $column = ? AND length >= ? AND length < ? ORDER BY RANDOM() LIMIT 10', [0, minLength, maxLength]);
    return List.generate(_dbwords.length, (i) {
      return WordModel.fromJson(_dbwords[i]);
    });
  }

  updateWord(WordModel wordModel) async{
    await (await db).update(
      tableName,
      wordModel.toMap(),
      // Ensure that the Dog has a matching id.
      where: "$word = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [wordModel.word],
    );
  }


}
