import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {

  int? id;
  String? title;
  DateTime? dateTime;
  bool? itsDone;

  Todo({this.dateTime ,this.title, this.itsDone});
}