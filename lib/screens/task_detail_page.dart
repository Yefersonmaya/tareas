import 'package:flutter/material.dart';
import '../models/task_model.dart'; // Asegúrate de tener el modelo de la tarea aquí

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Tarea'),
        backgroundColor: Colors.teal,
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.title, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'Título:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'Completada:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      task.isCompleted ? 'Sí' : 'No',
                      style: TextStyle(
                        fontSize: 18,
                        color: task.isCompleted ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
