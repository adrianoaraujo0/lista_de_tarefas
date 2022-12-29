import 'dart:developer';

import 'package:lista_de_tarefas/database/objectbox.g.dart';
import 'package:lista_de_tarefas/database/objectbox_database.dart';
import 'package:lista_de_tarefas/models/todo.dart';

class MenuRepository{

  List<Todo> findAllTasks() =>ObjectBoxDatabase.todoBox.getAll();

  List<Todo> findTasksToday(DateTime dateTime) {
    return ObjectBoxDatabase.todoBox.query(Todo_.dateTime.equals(dateTime.millisecondsSinceEpoch)).build().find();
  }

  void updateTask(Todo todo) => ObjectBoxDatabase.todoBox.put(todo);


  void deleteTask(List<int> ids){
    ObjectBoxDatabase.todoBox.removeMany(ids);
  }

}