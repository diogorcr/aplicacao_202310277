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
    String path = join(docsDir.path, 'tasksadmin_202310277.db');

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

  // CRUD TASKS
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks', orderBy: 'id DESC');
    return result.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertGrupo(Grupo grupo) async {
    final db = await database;
    return await db.insert('GRUPO_RESPONSAVEL', grupo.toMap());
  }

  Future<List<Grupo>> getGrupos() async {
    final db = await database;
    final result = await db.query('GRUPO_RESPONSAVEL', orderBy: 'id DESC');
    return result.map((e) => Grupo.fromMap(e)).toList();
  }

  Future<int> updateGrupo(Grupo grupo) async {
    final db = await database;
    return await db.update(
      'GRUPO_RESPONSAVEL',
      grupo.toMap(),
      where: 'id = ?',
      whereArgs: [grupo.id],
    );
  }

  Future<int> deleteGrupo(int id) async {
    final db = await database;
    return await db.delete(
      'GRUPO_RESPONSAVEL',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertPrioridade(Prioridade prioridade) async {
    final db = await database;
    return await db.insert('PRIORIDADE', prioridade.toMap());
  }

  Future<List<Prioridade>> getPrioridade() async {
    final db = await database;
    final result = await db.query('PRIORIDADE', orderBy: 'id DESC');
    return result.map((e) => Prioridade.fromMap(e)).toList();
  }

  Future<int> updatePrioridade(Prioridade prioridade) async {
    final db = await database;
    return await db.update(
      'PRIORIDADE',
      prioridade.toMap(),
      where: 'id = ?',
      whereArgs: [prioridade.id],
    );
  }

  Future<int> deletePrioridade(int id) async {
    final db = await database;

    return await db.delete('PRIORIDADE', where: 'id = ?', whereArgs: [id]);
  }
}
