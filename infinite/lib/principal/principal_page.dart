import 'package:flutter/material.dart';
import 'package:infinite/add_tasks/add_tasks_page.dart';

class PrincipalPage extends StatefulWidget {
  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  List<Map<String, String>> _tasks = [];

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
                  Text(
                    'João da Silva',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
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
                    color: Color(int.parse(_tasks[index]['color']!)), // Aplica a cor selecionada
                    child: ListTile(
                      title: Text(_tasks[index]['title']!),
                      subtitle: Text(
                          'Tarefa: ${_tasks[index]['task']!}, Prazo: ${_tasks[index]['dueDate']}'),
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
