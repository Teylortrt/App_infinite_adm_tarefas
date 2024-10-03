import 'package:flutter/material.dart';

class PrincipalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(child: Container()), // Placeholder for other content
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  // Action for adding a new item
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.purpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}