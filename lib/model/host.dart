class Host {
  int id;
  String content;

  Host(this.id, this.content);

  int get getId => id;
  set setId(int value) => id = value;

  String get getContent => content;
  set setContent(String value) => content = value;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
    };
  }
}