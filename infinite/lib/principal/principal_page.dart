import 'package:flutter/material.dart';
import 'package:infinite/screens/add_tasks/add_tasks_page.dart';
import 'package:infinite/repository/texto_repository.dart';

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  List<Map<String, String>> _tasks = [];

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _editTask(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskScreen(task: _tasks[index]),
      ),
    );

    if (result != null) {
      setState(() {
        _tasks[index] = result; // Atualiza a tarefa com os novos dados
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Infinite'),
            const SizedBox(width: 8),
            Image.asset(
              'assets/infinite.png',
              height: 30,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Bem-vindo',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(int.parse(_tasks[index]['color']!)),
                    child: ListTile(
                      title: Text(_tasks[index]['title']!),
                      subtitle: Text(
                          'Tarefa: ${_tasks[index]['task']!}, Prazo: ${_tasks[index]['dueDate']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editTask(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTask(index),
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
            MaterialPageRoute(builder: (context) => TaskScreen()),
          );

          if (result != null) {
            setState(() {
              _tasks.add(result);
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purpleAccent,
      ),
    );
  }
}
