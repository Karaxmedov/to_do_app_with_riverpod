import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app_with_riverpod/widgets/list_item.dart';
import 'package:to_do_app_with_riverpod/widgets/title_widget.dart';
import 'package:to_do_app_with_riverpod/widgets/toolbar_widget.dart';

import 'models/todo_model.dart';
import 'providers/all_providers.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final todoController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TodoModel> todoList = ref.watch(filteredTodoListProvider);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const TitleWidget(),
          TextField(
            controller: todoController,
            onSubmitted: (value) {
              ref
                  .read(todoListNotifierProvider.notifier)
                  .addTodo(description: value);
            },
            decoration: const InputDecoration(
              labelText: "What will you do?",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ToolbarWidget(),
          for (TodoModel todo in todoList)
            Dismissible(
              key: ValueKey(todo.id),
              child: ProviderScope(
                overrides: [
                  currentTodoPovider.overrideWith(
                    (ref) => todo,
                  ),
                ],
                child: const ListItem(),
              ),
              onDismissed: (direction) {
                ref
                    .read(todoListNotifierProvider.notifier)
                    .removeTodo(todoid: todo.id);
              },
            ),
        ],
      ),
    );
  }
}
