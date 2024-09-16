import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/task_notifier.dart';
import 'task_detail_page.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Tareas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: taskList.isEmpty
          ? Center(
              child: Text(
                'No hay tareas pendientes',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];

                return Dismissible(
                  key: Key(task.title),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    ref.read(taskListProvider.notifier).toggleTask(index);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: task.isCompleted,
                        activeColor: Colors.teal,
                        onChanged: (value) {
                          ref.read(taskListProvider.notifier).toggleTask(index);
                        },
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 18,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: task.isCompleted
                              ? Colors.grey
                              : Colors.black87,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.teal,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailPage(task: task),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          _showAddTaskDialog(context, ref);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {
            ref.read(taskListProvider.notifier).deleteCompletedTasks();
          },
          icon: Icon(Icons.delete),
          label: Text('Eliminar tareas completadas'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,  // Cambiado de primary a backgroundColor
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15),
            textStyle: TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar nueva tarea'),
          content: TextField(
            controller: taskController,
            decoration: InputDecoration(hintText: 'Escribe la tarea aquí'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  ref.read(taskListProvider.notifier).addTask(taskController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Agregar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,  // Cambiado de primary a backgroundColor
              ),
            ),
          ],
        );
      },
    );
  }
}
