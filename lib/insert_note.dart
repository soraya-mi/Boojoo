


class challengecreate{
  String title;
  String content;

  challengecreate({this.title, this.content});

  Map<String,dynamic> toJson(){
    return {
      "title": title,
      "content": content,
    };
  }
}