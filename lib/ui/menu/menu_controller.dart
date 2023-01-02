import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/menu/menu_repository.dart';
import 'package:rxdart/subjects.dart';

class MenuController{

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  MenuRepository menuRepository = MenuRepository();
  BehaviorSubject<List<Todo>> streamTasks = BehaviorSubject<List<Todo>>();
  BehaviorSubject<bool> streamDeleteTasks = BehaviorSubject<bool>();
  BehaviorSubject<String> streamFilterTasks = BehaviorSubject<String>();

  void updatelistTasks()=> streamTasks.sink.add(menuRepository.findAllTasks());


  void updateTask(Todo todo){
    if(todo.itsDone == null || todo.itsDone == false){
      todo.itsDone = true;
    }else{
      todo.itsDone = false;
    }
    menuRepository.updateTask(todo);
    streamDeleteTasks.sink.add(completedTasks().isNotEmpty);

    updatelistTasks();
  }

  List<Todo> completedTasks()=> menuRepository.findAllTasks().where((element) => element.itsDone == true).toList();

  void deleteTask(){
    if(completedTasks().isNotEmpty){
      menuRepository.deleteTask(completedTasks().map((e) => e.id!).toList());
      updatelistTasks();
      streamDeleteTasks.sink.add(completedTasks().isNotEmpty);
    }
  }

  void filterTasks(String day){
    DateTime now = DateTime.parse(DateTime.now().toString().split(" ").first);

    if(day == "All"){

      updatelistTasks();

    }else if(day == "Today"){

      streamTasks.sink.add(menuRepository.findTasks(now));

    }else if(day == "Tomorrow"){

      streamTasks.sink.add(menuRepository.findTasks(now.add(const Duration(days: 1))));

    }else{

      streamTasks.sink.add(menuRepository.findTasks(now.subtract(const Duration(days: 7))));

    }
  }
 

}