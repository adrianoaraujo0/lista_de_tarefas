import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {

  @Id()
  int? id;

  @Unique()
  String? uuid;
  
  String? title;
  
  DateTime? dateTime;
  bool? itsDone;

  Todo({this.dateTime, this.uuid, this.title, this.itsDone});


  factory Todo.fromMap(Map map){
    //Convertendo TIMESTAMP para DATETIME
    Timestamp timestamp = map["date"];
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return Todo(
      dateTime: date,
      uuid: map["uuid"],
      title: map["title"],
      itsDone: map["itsDone"],
    );
  }

  @override
  String toString() {
    return "$id, $title, $dateTime, $itsDone";
  }

}