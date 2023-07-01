import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app_with_riverpod/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);
  addTodo({required String description}) {
    var todo = TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, todo];
  }

  removeTodo({required String todoid}) {
    state = [
      for (final todo in state)
        if (todo.id != todoid) todo,
    ];
  }

  toggle(String todoid) {
    state = [
      for (final todo in state)
        if (todo.id == todoid)
          (TodoModel(
              id: todoid,
              description: todo.description,
              completed: !todo.completed))
        else
          (todo)
    ];
    return state;
  }

  edit(String todoid, description) {
    state = [
      for (final todo in state)
        if (todo.id == todoid)
          (TodoModel(
              id: todoid, description: description, completed: todo.completed))
        else
          (todo)
    ];

    return state;
  }
}
