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

  const DatabaseClient._privateConstructor();
  static const DatabaseClient instance = DatabaseClient._privateConstructor();

  // Only allow a single open connection to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // Open the database
  Future<Database> _initDatabase() async {
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
      $columnRemindOn TEXT NOT NULL
    )
    ''');
  }

  Future<String> insertAffirmation(AffirmationEntity affirmation) async {
    Database db = await database;
    await db.insert(tableAffirmations, affirmation.toMap());
    return affirmation.id;
  }

  Future<AffirmationEntity> updateAffirmation(
      AffirmationEntity affirmationEntity) async {
    Database db = await database;
    await db.update(tableAffirmations, affirmationEntity.toMap());
    return affirmationEntity;
  }

  Future<List<AffirmationEntity>> fetchAffirmations() async {
    Database db = await database;
    var affirmationsMaps = await db.query(tableAffirmations);
    var affirmations = <AffirmationEntity>[];
    affirmationsMaps.forEach((affirmationMap) {
      affirmations.add(AffirmationEntity.fromMap(affirmationMap));
    });
    return affirmations;
  }

  Future<AffirmationEntity> fetchAffirmationWithId(String id) async {
    Database db = await database;
    var affirmationMap = await db
        .query(tableAffirmations, where: '$columnId = $id', whereArgs: [id]);
    if (affirmationMap.isNotEmpty) {
      return AffirmationEntity.fromMap(affirmationMap.first);
    } else {
      throw Exception('Affirmation not found');
    }
  }

  Future deleteAffirmationWithId(String id) async {
    Database db = await database;
    await db.delete(
      tableAffirmations,
      where: '$columnId = $id',
      whereArgs: [id],
    );
  }
}
