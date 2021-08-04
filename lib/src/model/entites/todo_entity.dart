class TodoEntity {
  final String content;
  final int timeStamp;

  TodoEntity(this.content, this.timeStamp);

  Map<String, dynamic> toMap() {
    return {
      "content": this.content,
      "timeStamp": this.timeStamp,
    };
  }

  static TodoEntity toJson(Map<String, dynamic> json) {
    return TodoEntity(json["content"], json["timeStamp"]);
  }
}
