class Todo{
  int id;
  String title;
  String body;
  bool important;
  int author;

  bool animationStatus=false;

  Todo({this.id, this.title, this.body, this.important, this.author});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        id:json['id'], title: json['title'], body: json['title'], important: json['important'], author: json['author']);
  }
  dynamic toJson() => {'id': id, 'author': author, 'title': title, 'important': important, 'body': body};
}