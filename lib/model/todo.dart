class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '1', todoText: 'Stop the alarm', isDone: true),
      ToDo(id: '2', todoText: 'Switch the light on', isDone: true),
      ToDo(id: '3', todoText: 'Brush'),
      ToDo(id: '4', todoText: 'Eat breakfast'),
      ToDo(id: '5', todoText: 'Goto Eco Class (Never)'),
      ToDo(id: '6', todoText: 'Sleep'),
    ];
  }
}
