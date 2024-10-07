import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // Para usar join

class DBHelper {
  static const _dbVersion = 1;
  static const _dbName = 'tasks_db.db';
  static const _tableName = 'tasks';
  static const _sql = '''
  CREATE TABLE $_tableName(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    tarefa TEXT NOT NULL,
    title TEXT NOT NULL,
    dueDate TEXT NOT NULL,
    color TEXT NOT NULL
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

  // Inserir tarefa associada ao utilizador
  static Future<void> insertTask(String email, String senha, Map<String, String> taskData) async {
    final db = await getInstancia();
    await db.insert(
      _tableName,
      {
        'email': email,
        'senha': senha,
        'tarefa': taskData['task']!,
        'title': taskData['title']!,
        'dueDate': taskData['dueDate']!,
        'color': taskData['color']!,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Buscar todas as tarefas para o utilizador logado
  static Future<List<Map<String, dynamic>>> getTasks(String email, String senha) async {
    final db = await getInstancia();
    return await db.query(
      _tableName,
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
  }

  // Atualizar uma tarefa pelo ID
  static Future<void> updateTask(int id, Map<String, String> taskData) async {
    final db = await getInstancia();
    await db.update(
      _tableName,
      {
        'tarefa': taskData['task']!,
        'title': taskData['title']!,
        'dueDate': taskData['dueDate']!,
        'color': taskData['color']!,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Excluir uma tarefa pelo ID
  static Future<void> deleteTask(int id) async {
    final db = await getInstancia();
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Verificar as credenciais do utilizador
  static Future<bool> verifyCredentials(String email, String senha) async {
    final db = await getInstancia();
    final result = await db.query(
      _tableName,
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    return result.isNotEmpty;
  }
}
