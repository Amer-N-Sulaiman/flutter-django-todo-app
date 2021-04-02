class Todo{
  String title;
  String body;
  int author;

  Todo({this.title, this.body, this.author});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        title: json['title'], body: json['title'], author: json['body']);
  }
  dynamic toJson() => {'author': author, 'title': title, 'body': body};
}