import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:infinite/repository/text_repository.dart';
import 'package:infinite/screens/add_tasks/add_tasks_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:infinite/repository/db_helper.dart';

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  List<Map<String, dynamic>> _tasks = [];
  String? _email;
  String? _senha;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Carrega o email e senha do utilizador logado
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email');
      _senha = prefs.getString('senha');
    });

    // Se email e senha estiverem disponíveis, carregar as tarefas do utilizador
    if (_email != null && _senha != null) {
      await _loadTasks();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: email ou senha não definidos.')),
      );
    }
  }

  // Carrega as tarefas do utilizador logado
  Future<void> _loadTasks() async {
    if (_email != null && _senha != null) {
      try {
        final tasks = await ContactRepository.getTasks(_email!, _senha!);
        if (tasks != null) {
          setState(() {
            _tasks = List<Map<String, dynamic>>.from(tasks);
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar as tarefas: $e')),
        );
      }
    }
  }

  // Adiciona uma nova tarefa
  Future<void> _addTask(Map<String, dynamic> taskData) async {
    try {
      final result = await someAsyncTaskFunction(taskData);

      if (result != null && result is Map<String, dynamic>) {
        // Adiciona a tarefa diretamente na lista local
        setState(() {
          _tasks.add(result); // Adiciona a nova tarefa na lista local
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tarefa adicionada com sucesso!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: Não foi possível adicionar a tarefa.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: Ocorreu um problema. $e')),
      );
    }
  }

  // Exemplo de função assíncrona simulada para adicionar a tarefa (substitua pela lógica real)
  Future<Map<String, dynamic>?> someAsyncTaskFunction(
      Map<String, dynamic> taskData) async {
    await Future.delayed(
        Duration(seconds: 1)); // Simula o tempo de espera de uma operação
    return taskData; // Retorna os dados da tarefa como se tivesse sido adicionada com sucesso
  }

  // Edita uma tarefa existente
  Future<void> _editTask(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TaskScreen(task: _tasks[index]), // Passa a tarefa para edição
      ),
    );

    if (result != null) {
      await ContactRepository.updateTask(_tasks[index]['id'], result);
      _loadTasks(); // Recarrega as tarefas após a edição
    }
  }

  // Apaga uma tarefa
  Future<void> _deleteTask(int id) async {
    await ContactRepository.deleteTask(id);
    _loadTasks(); // Recarrega as tarefas após apagar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_tasks[index]['title']),
                      subtitle: Text(
                          'Tarefa: ${_tasks[index]['task']}, Prazo: ${_tasks[index]['dueDate']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editTask(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteTask(_tasks[index]['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TaskScreen()), // Abre a tela de adicionar tarefa
          );

          if (result != null) {
            await _addTask(result); // Adiciona a nova tarefa
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

