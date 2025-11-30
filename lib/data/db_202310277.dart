import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/tasks.dart';
import '../models/grupo.dart';
import '../models/prioridade.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        // MUITO IMPORTANTE: habilitar foreign keys
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: createDatabase,
    );
  }

  Future createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE GRUPO_RESPONSAVEL (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE PRIORIDADE (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE TASKS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT NOT NULL,
        prioridade_id INTEGER NOT NULL,
        criadoEm DATETIME,
        grupoResponsavel_id INTEGER NOT NULL,
        finalizado INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (prioridade_id) REFERENCES PRIORIDADE(id),
        FOREIGN KEY (grupoResponsavel_id) REFERENCES GRUPO_RESPONSAVEL(id)
      );
    ''');
  }
}
