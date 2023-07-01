import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app_with_riverpod/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

import '../models/todo_model.dart';

enum Filter { all, active, completed }

final currentFilterProvider = StateProvider<Filter>((ref) => Filter.all);

final filteredTodoListProvider = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(currentFilterProvider);
  final filteredTodoList = ref.watch(todoListNotifierProvider);
  switch (filter) {
    case Filter.all:
      return filteredTodoList;
    case Filter.active:
      return filteredTodoList.where((element) => !element.completed).toList();
    case Filter.completed:
      return filteredTodoList.where((element) => element.completed).toList();
  }
});
final todoListNotifierProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>(
  (ref) => TodoListManager([
    TodoModel(id: const Uuid().v4(), description: "1"),
    TodoModel(id: const Uuid().v4(), description: "2"),
    TodoModel(id: const Uuid().v4(), description: "3"),
    TodoModel(id: const Uuid().v4(), description: "4"),
    TodoModel(id: const Uuid().v4(), description: "5"),
    TodoModel(id: const Uuid().v4(), description: "6"),
  ]),
);

final unCompletedTodoCount = Provider<int>(
  (ref) {
    final allTodo = ref
        .watch(todoListNotifierProvider)
        .where((element) => !element.completed);
    return allTodo.length;
  },
);
final currentTodoPovider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
