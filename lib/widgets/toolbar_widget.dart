import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/all_providers.dart';

class ToolbarWidget extends ConsumerWidget {
  ToolbarWidget({super.key});
  Filter _filter = Filter.all;
  Color changeColor(Filter filter) {
    return _filter == filter ? Colors.orange : Colors.blue.shade900;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _filter = ref.watch(currentFilterProvider);
    return Row(
      children: [
        Expanded(
          child: Text("${ref.watch(unCompletedTodoCount)} Todos"),
        ),
        Tooltip(
          message: "All Todos",
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: changeColor(Filter.all),
            ),
            onPressed: () {
              ref.read(currentFilterProvider.notifier).state = Filter.all;
            },
            child: const Text("All"),
          ),
        ),
        Tooltip(
          message: "Only uncompleted Todos",
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: changeColor(Filter.active),
            ),
            onPressed: () {
              ref.read(currentFilterProvider.notifier).state = Filter.active;
            },
            child: const Text("Active"),
          ),
        ),
        Tooltip(
          message: "Only completed Todos",
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: changeColor(Filter.completed),
            ),
            onPressed: () {
              ref.read(currentFilterProvider.notifier).state = Filter.completed;
            },
            child: const Text("Completed"),
          ),
        ),
      ],
    );
  }
}
