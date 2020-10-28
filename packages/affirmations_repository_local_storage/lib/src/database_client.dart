import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:affirmations_repository_core/affirmations_repository_core.dart';

class DatabaseClient {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = 'AffirmationsApp.db';
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  DatabaseClient._privateConstructor();
  static final DatabaseClient instance = DatabaseClient._privateConstructor();

  // Only allow a single open connection to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // Open the database
  _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL String to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableAffirmations (
      $columnId TEXT PRIMARY KEY,
      $columnMessage TEXT NOT NULL,
      $columnRemindOn TEXT NOT NULL,
    )
    ''');
  }
}
