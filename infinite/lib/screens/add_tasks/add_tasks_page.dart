import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  final Map<String, dynamic>? task; // Tarefa opcional para editar

  TaskScreen({this.task}); // Construtor que aceita tarefa opcional

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  String _dueDate = 'Data não definida';
  String _selectedColor = '0xFF52B0E5'; // Cor padrão

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      // Se estiver editando, inicializa os campos com os valores da tarefa
      _titleController.text = widget.task!['title'];
      _taskController.text = widget.task!['task'];
      _dueDate = widget.task!['dueDate'] ?? 'Data não definida';
      _selectedColor = widget.task!['color'] ?? '0xFF52B0E5';
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dueDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _saveTask(BuildContext context) {
    if (_taskController.text.isNotEmpty && _titleController.text.isNotEmpty) {
      Navigator.pop(context, {
        'title': _titleController.text,
        'task': _taskController.text,
        'dueDate': _dueDate,
        'color': _selectedColor,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior
          },
        ),
        title: Text(widget.task == null ? 'Nova Tarefa' : 'Editar Tarefa'),
        backgroundColor: Color(0xFF52B0E5),
      ),
      body: Container(
        color: Color(0xFF1980BA),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/infinite.png',
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Descrição da Tarefa',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Insira o título da tarefa aqui',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'O que deve ser feito?',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: 'Insira sua nova tarefa aqui',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Prazo',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dueDate,
                      style: TextStyle(color: Colors.black),
                    ),
                    Image.asset(
                      'assets/calendario.png',
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Escolha uma cor',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            DropdownButton<String>(
              value: _selectedColor,
              items: [
                DropdownMenuItem(
                  value: '0xFF52B0E5',
                  child: Text('Azul Claro'),
                ),
                DropdownMenuItem(
                  value: '0xFF1980BA',
                  child: Text('Azul Escuro'),
                ),
                DropdownMenuItem(
                  value: '0xFF3A8CD8',
                  child: Text('Azul Médio'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedColor = value!;
                });
              },
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () => _saveTask(context), // Salva a tarefa ao clicar
                backgroundColor: Colors.green,
                child: Image.asset(
                  'assets/certinho.png',
                  height: 40,
                  width: 40,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

