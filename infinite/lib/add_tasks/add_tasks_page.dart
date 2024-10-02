import 'package:flutter/material.dart';

  @override
 
class TaskScreen extends StatefulWidget {  
  @override  
  _TaskScreenState createState() => _TaskScreenState();  
}  

class _TaskScreenState extends State<TaskScreen> {  
  final TextEditingController _taskController = TextEditingController();  
  final TextEditingController _titleController = TextEditingController();  // Controlador para o título
  String _dueDate = 'Data não definida';  
  List<Map<String, String>> _tasks = []; // Para armazenar as tarefas

  void _selectDate(BuildContext context) async {  
    final DateTime? picked = await showDatePicker(  
      context: context,  
      initialDate: DateTime.now(),  
      firstDate: DateTime(2000),  
      lastDate: DateTime(2101),  
    );  
    if (picked != null && picked != DateTime.now())  
      setState(() {  
        _dueDate = "${picked.toLocal()}".split(' ')[0];  
      });  
  }  

  void _saveTask() {  
    if (_taskController.text.isNotEmpty && _titleController.text.isNotEmpty) {  
      setState(() {  
        _tasks.add({'task': _taskController.text, 'title': _titleController.text, 'dueDate': _dueDate});  
        _taskController.clear();  
        _titleController.clear();  // Limpa o campo do título
        _dueDate = 'Data não definida';  
      });  
    }  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        leading: IconButton(  // Botão de voltar no canto esquerdo
          icon: Icon(Icons.arrow_back),  
          onPressed: () {  
            Navigator.pop(context);  // Faz a navegação para voltar
          },  
        ),  
        title: Text('Tarefas'),  
        backgroundColor: Color(0xFF52B0E5),  // Cor da AppBar ajustada
      ),  
      body: Container(  
        color: Color(0xFF1980BA),  // Fundo do corpo da tela original
        padding: EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Center( // Adicionando o símbolo do infinito no topo
              child: Image.asset(
                'assets/infinite.png', // Certifique-se de que este caminho está correto
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(  // Título da Descrição
              'Descrição da Tarefa',  
              style: TextStyle(color: Colors.black, fontSize: 18),  
            ),
            SizedBox(height: 10),  // Espaçamento entre o título e o campo de texto
            TextField(  
              controller: _titleController,  // Controlador do título
              decoration: InputDecoration(  
                hintText: 'Insira o título da tarefa aqui',  
                filled: true,  
                fillColor: Colors.white,  
                border: OutlineInputBorder(),  
              ),  
            ),
            SizedBox(height: 20),  // Espaçamento entre o campo do título e o próximo título
            Text(  
              'O que deve ser feito?',  
              style: TextStyle(color: Colors.black, fontSize: 18),  // Texto de cor preta
            ),  
            SizedBox(height: 10),  // Espaçamento entre os títulos e o campo de descrição
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
              style: TextStyle(color: Colors.black, fontSize: 18),  // Texto de cor preta
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Coloca o texto à esquerda e a imagem à direita
                  children: [  
                    Text(  
                      _dueDate,  
                      style: TextStyle(color: Colors.black),  
                    ),  
                    Image.asset(  
                      'assets/calendario.png',  // Imagem do calendário
                      height: 24,  
                      width: 24,  
                    ),  
                  ],  
                ),  
              ),  
            ),  
            Spacer(),  
            Align(  
              alignment: Alignment.bottomRight,  
              child: FloatingActionButton(  
                onPressed: _saveTask,  
                backgroundColor: Colors.green,  
                child: Image.asset(  
                  'assets/certinho.png',  // Imagem do "certinho"
                  height: 40,  // Ajustando o tamanho da imagem do certinho
                  width: 40,  
                ),  
              ),  
            ),  
            SizedBox(height: 20),  
            Expanded(  
              child: ListView.builder(  
                itemCount: _tasks.length,  
                itemBuilder: (context, index) {  
                  return Card(  
                    child: ListTile(  
                      title: Text(_tasks[index]['title']!),  // Exibindo o título da tarefa
                      subtitle: Text('Tarefa: ${_tasks[index]['task']!}, Prazo: ${_tasks[index]['dueDate']}'),  
                    ),  
                  );  
                },  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}