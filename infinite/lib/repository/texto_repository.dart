import 'package:flutter/material.dart';
import 'db_helper.dart'; // Certifique-se de importar o DBHelper corretamente

class ContactRepository {
  static const _tableName = 'tasks';

  // Função para inserir uma nova tarefa
  static Future<int> insert(Map<String, Object?> map) async {
    final db = await DBHelper.getInstancia(); // Corrigido para chamar o DBHelper
    return await db.insert(_tableName, map);
  }

  // Função para buscar todas as tarefas
  static Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await DBHelper.getInstancia();
    return await db.query(_tableName);
  }
}
