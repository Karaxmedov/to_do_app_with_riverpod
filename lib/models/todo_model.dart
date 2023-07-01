class TodoModel {
  final String id;
  final String description;
  final bool completed;

  TodoModel({
    required this.id,
    required this.description,
    this.completed = false,
  });
  @override
  String toString() {
    // TODO: implement toString
    return "$id ==== $description";
  }
}
