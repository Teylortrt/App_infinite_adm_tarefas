// ignore: unused_import
import 'package:flutter/material.dart';
import 'db_helper.dart'; // Certifique-se de importar o DBHelper corretamente
import 'package:sqflite/sqflite.dart';
class ContactRepository {
  static const _tableName = 'task';

  // Função para inserir uma nova tarefa com email, senha e os detalhes da tarefa
static Future<int> insertTask(String email, String senha, Map<String, dynamic> taskData) async {
    final db = await DBHelper.getInstancia();
    return await db.insert(
      _tableName,
      {
        'email': email,
        'senha': senha,
        'title': taskData['title']!, 
        'tarefa': taskData['task']!,
        'dueDate': taskData['dueDate']!, 
        'color': taskData['color']!, 
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
}

  // Função para buscar todas as tarefas de um utilizador específico (por email e senha)
  static Future<List<Map<String, dynamic>>> getTasks(String email, String senha) async {
    final db = await DBHelper.getInstancia();
    return await db.query(
      _tableName,
      where: 'email = ? AND senha = ?', // Filtra pelas credenciais do utilizador
      whereArgs: [email, senha],
    );
  }

  // Função para apagar uma tarefa pelo ID
  static Future<int> deleteTask(int id) async {
    final db = await DBHelper.getInstancia();
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Função para atualizar uma tarefa existente
  static Future<int> updateTask(int id, Map<String, String> taskData) async {
    final db = await DBHelper.getInstancia();
    return await db.update(
      _tableName,
      {
        'title': taskData['title']!,
        'tarefa': taskData['task']!,
        'dueDate': taskData['dueDate']!,
        'color': taskData['color']!,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
