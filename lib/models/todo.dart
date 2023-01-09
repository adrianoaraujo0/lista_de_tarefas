import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {

  int? id;
  String? title;
  
  DateTime? dateTime;
  bool? itsDone;

  Todo({this.dateTime ,this.title, this.itsDone});

  static Map<String, dynamic> toMap(Todo todo){
    return {
      "title" : todo.title,
      "date" : todo.dateTime,
      "itsDone" : todo.itsDone,
    };
  }

  factory Todo.fromMap(Map map){
    return Todo(
      dateTime: map["date"],
      title: map["title"],
      itsDone: map["itsDone"]
    );
  }

  @override
  String toString() {
    return "$id, $title, $dateTime, $itsDone";
  }

}