import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';

// Proveedor para la lista de tareas
final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((ref) {
  return TaskListNotifier();
});

// StateNotifier para manejar la lista de tareas
class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  // Agregar una nueva tarea
  void addTask(String title) {
    state = [...state, Task(title: title)];
  }

  // Marcar o desmarcar una tarea como completada
  void toggleTask(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) Task(title: state[i].title, isCompleted: !state[i].isCompleted) else state[i],
    ];
  }

  // Eliminar todas las tareas completadas
  void deleteCompletedTasks() {
    state = state.where((task) => !task.isCompleted).toList();
  }
}
