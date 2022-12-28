import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {

  int? id;
  String? title;
  DateTime? dateTime;
  
  @Transient()
  bool itsDone;

  Todo([ this.dateTime ,this.title, this.itsDone = false]);
}