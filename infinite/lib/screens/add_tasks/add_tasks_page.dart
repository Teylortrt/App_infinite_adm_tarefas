import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  String _dueDate = 'Data não definida';
  String _selectedColor = '0xFF52B0E5'; // Cor padrão selecionada

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dueDate = "${picked.toLocal()}".split(' ')[0]; // Formata a data para o formato legível
      });
    }
  }

  void _saveTask(BuildContext context) {
    if (_taskController.text.isNotEmpty && _titleController.text.isNotEmpty) {
      // Verifica se os campos necessários foram preenchidos
      Navigator.pop(context, {
        'title': _titleController.text, // Passa o título da tarefa
        'task': _taskController.text, // Passa a descrição da tarefa
        'dueDate': _dueDate, // Passa a data escolhida
        'color': _selectedColor, // Passa a cor selecionada
      });
    } else {
      // Se algum campo estiver vazio, pode exibir um alerta ou aviso
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
        title: Text('Tarefas'),
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
