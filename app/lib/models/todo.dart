class Todo{
  String title;
  String body;
  bool important;
  int author;

  Todo({this.title, this.body, this.important, this.author});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        title: json['title'], body: json['title'], important: json['important'], author: json['body']);
  }
  dynamic toJson() => {'author': author, 'title': title, 'important': important, 'body': body};
}