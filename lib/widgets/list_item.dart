import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/all_providers.dart';

class ListItem extends ConsumerStatefulWidget {
  const ListItem({super.key});

  @override
  ConsumerState<ListItem> createState() => _ListItemState();
}

class _ListItemState extends ConsumerState<ListItem> {
  late FocusNode focusNode;
  late TextEditingController textEditingController;
  bool _hasFocus = false;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = ref.watch(currentTodoPovider);

    return Focus(
      onFocusChange: (value) {
        if (!value) {
          setState(() {
            _hasFocus = false;
            ref
                .read(todoListNotifierProvider.notifier)
                .edit(currentItem.id, textEditingController.text);
          });
        }
      },
      child: ListTile(
          onTap: () {
            setState(() {
              _hasFocus = true;
              focusNode.requestFocus();
              textEditingController.text = currentItem.description;
            });
          },
          leading: Checkbox(
            value: currentItem.completed,
            onChanged: (value) {
              ref
                  .read(todoListNotifierProvider.notifier)
                  .toggle(currentItem.id);
            },
          ),
          title: _hasFocus
              ? TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                )
              : Text(currentItem.description)),
    );
  }
}
