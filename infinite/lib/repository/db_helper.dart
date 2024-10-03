import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // Importação necessária para usar join
import 'package:flutter/material.dart';

class DBHelper {
  static const _dbVersion = 1;
  static const _dbName = 'tasks_db.db';
  static const _tableName = 'tasks';
  static const _sql = '''
  CREATE TABLE $_tableName(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    tarefa TEXT NOT NULL
  );
''';

  static Future<Database> getInstancia() async {
    final path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) {
        db.execute(_sql);
      },
    );
  }

  // Função para inserir uma nova tarefa
  static Future<void> insertTask(String email, String senha, String tarefa) async {
    final db = await getInstancia();
    await db.insert(
      _tableName,
      {
        'email': email,
        'senha': senha,
        'tarefa': tarefa,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Função para buscar todas as tarefas
  static Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await getInstancia();
    return await db.query(_tableName);
  }
}
