import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {

  int? id;
  String title;
  DateTime dateTime;

  Todo({required this.title, required this.dateTime});
}