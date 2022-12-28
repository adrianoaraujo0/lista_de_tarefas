import 'dart:developer';

import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/menu/menu_repository.dart';
import 'package:rxdart/subjects.dart';

class MenuController{

  MenuRepository menuRepository = MenuRepository();
  BehaviorSubject<List<Todo>> streamTasks = BehaviorSubject<List<Todo>>();

  void listTasks(){
    streamTasks.sink.add(menuRepository.findAllTasks());
  }

  void updateTask(Todo todo){
    todo.itsDone = !todo.itsDone;
    menuRepository.updateTask(todo);
    listTasks();
  }

}