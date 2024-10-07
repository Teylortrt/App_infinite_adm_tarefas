// ignore: unused_import
import 'package:flutter/material.dart';
import 'db_helper.dart'; // Certifique-se de importar o DBHelper corretamente
import 'package:sqflite/sqflite.dart';
class ContactRepository {
  static const _tableName = 'task';

  // Função para inserir uma nova tarefa com a estrutura da classe Task
  static Future<int> insertTask(Task task) async {
    final db = await DBHelper.getInstancia();
    return await db.insert(
      _tableName,
      task.toMap(), // Converte a instância de Task em Map
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Função para buscar todas as tarefas de um utilizador específico (por email e senha)
  static Future<List<Task>> getTasks(String email, String senha) async {
    final db = await DBHelper.getInstancia();
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'email = ? AND senha = ?', // Filtra pelas credenciais do utilizador
      whereArgs: [email, senha],
    );

    // Converte cada Map em uma instância de Task
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
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
  static Future<int> updateTask(int id, Task task) async {
    final db = await DBHelper.getInstancia();
    return await db.update(
      _tableName,
      task.toMap(), // Converte a instância de Task em Map
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class Task {
  final String email;
  final String senha;
  final String title;
  final String task;
  final String dueDate;
  final String color;

  Task({
    required this.email,
    required this.senha,
    required this.title,
    required this.task,
    required this.dueDate,
    required this.color,
  });

  // Converte os dados para Map, útil para inserir no banco de dados
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'senha': senha,
      'title': title,
      'task': task,
      'dueDate': dueDate,
      'color': color,
    };
  }

  // Converte um Map em uma instância de Task, útil ao buscar tarefas do banco
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      email: map['email'],
      senha: map['senha'],
      title: map['title'],
      task: map['task'],
      dueDate: map['dueDate'],
      color: map['color'],
    );
  }
}

