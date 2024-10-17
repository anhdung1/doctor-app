import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_state.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE screen_state(id INTEGER PRIMARY KEY, text TEXT, imageUrl TEXT)',
        );
      },
    );
  }

  Future<void> insertState(String text, String imageUrl) async {
    final db = await database;
    await db.insert(
      'screen_state',
      {'id': 1, 'text': text, 'imageUrl': imageUrl},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getState() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('screen_state', where: 'id = ?', whereArgs: [1]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}
