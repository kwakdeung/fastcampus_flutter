import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  final String id;
  final String title;
  bool isCompleted;

  Todo({required this.id, required this.title, this.isCompleted = false});
}

final todoListProvider =
    StateNotifierProvider<ToDoListNotifier, List<Todo>>((ref) {
  return ToDoListNotifier();
});

class ToDoListNotifier extends StateNotifier<List<Todo>> {
  ToDoListNotifier() : super([]);

  void addTodo(String title) {
    final todo = Todo(id: DateTime.now().toString(), title: title);
    state = [...state, todo];
  }

  void toggleTodoStatus(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
            id: todo.id, title: todo.title, isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
  }
}

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todo = todoList[index];
          return ListTile(
            title: Text(todo.title),
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) =>
                  ref.read(todoListProvider.notifier).toggleTodoStatus(todo.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(todoListProvider.notifier).addTodo("New Todo"),
        child: const Icon(Icons.add),
      ),
    );
  }
}
