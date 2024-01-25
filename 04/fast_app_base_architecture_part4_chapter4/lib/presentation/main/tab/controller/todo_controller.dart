import 'package:fast_app_base_architecture/data/memory/vo_todo.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@singleton
class TodoController extends GetxController {
  final RxList<Todo> todoList = <Todo>[].obs;

  void refreshTodos() async {
    try {
      final remoteTodoList = await ReadTodosUseCase().execute();
      todoList.
    }
  }
}
