import 'dart:math';

import 'package:lista_de_tarefas/database/objectbox.g.dart';
import 'package:lista_de_tarefas/database/objectbox_database.dart';
import 'package:lista_de_tarefas/models/todo.dart';

class MenuRepository{

  List<Todo> findAllTasks() {

    return ObjectBoxDatabase.todoBox.query().order(Todo_.dateTime).build().find();
  }

  List<Todo> findTasks(DateTime dateTime) {
    return ObjectBoxDatabase.todoBox.query(Todo_.dateTime.equals(dateTime.millisecondsSinceEpoch)).order(Todo_.dateTime).build().find();
  }

  List<Todo> findTasksCompleted(bool isCompleted){
    return ObjectBoxDatabase.todoBox.query(Todo_.itsDone.equals(isCompleted)).order(Todo_.dateTime).build().find();
  }

  void updateTask(Todo todo) => ObjectBoxDatabase.todoBox.put(todo);

  void deleteTask(List<int> ids)=> ObjectBoxDatabase.todoBox.removeMany(ids);


}