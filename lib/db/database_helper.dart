import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "vocab_stocker.db";
  static final _databaseVersion = 1;

  static final tableVocabulary = 'vocabulary';
  static final tableGenres = 'genres';

  // 単語テーブルのカラム名
  static final columnId = '_id';
  static final columnWord = 'word';
  static final columnMeaning = 'meaning';
  static final columnGenre = 'genre';

  // シングルトンパターンでインスタンスを作成
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // 単語テーブル作成
    await db.execute('''
          CREATE TABLE $tableVocabulary (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnWord TEXT NOT NULL,
            $columnMeaning TEXT,
            $columnGenre TEXT
          )
          ''');

    // ジャンルテーブル作成
    await db.execute('''
          CREATE TABLE $tableGenres (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnGenre TEXT NOT NULL
          )
          ''');
  }

  // 単語を追加する
  Future<int> insertVocabulary(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableVocabulary, row);
  }

  // 単語リストを取得する
  Future<List<Map<String, dynamic>>> getAllVocabulary() async {
    Database db = await instance.database;
    return await db.query(tableVocabulary);
  }

  // ジャンルを追加する
  Future<int> insertGenre(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableGenres, row);
  }

  // ジャンルリストを取得する
  Future<List<Map<String, dynamic>>> getAllGenres() async {
    Database db = await instance.database;
    return await db.query(tableGenres);
  }
}
