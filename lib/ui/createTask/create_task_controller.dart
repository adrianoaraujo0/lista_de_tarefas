import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/createTask/create_task_repository.dart';
import 'package:lista_de_tarefas/ui/menu/menu_controller.dart';
import 'package:rxdart/subjects.dart';

class CreateTaskController{

  MenuController menuController = MenuController();

  TextEditingController taskController = TextEditingController();
  BehaviorSubject<String> streamSelectDate = BehaviorSubject<String>();
  BehaviorSubject<Todo> streamTodo = BehaviorSubject<Todo>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CreateTaskRepository createTaskRepository = CreateTaskRepository();

  void addTask(BuildContext context, Todo? todo){
    formKey.currentState!.validate();
    validateDate(context, todo);

    if(formKey.currentState!.validate() && validateDate(context, todo)){
      todo!.title = taskController.text;
      todo.itsDone = false;
      createTaskRepository.addTask(todo);
      clearObject();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saved task"))
      );
    }
  }

  clearObject(){
    taskController.clear();
    streamTodo.sink.add(Todo());
    streamSelectDate.sink.add("");
  }


 bool validateDate(BuildContext context ,Todo? todo){
    if(todo?.dateTime == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select Task Date"))
      );
      return false;
    }
      return true;
  }

  Future<DateTime?> pickDate( BuildContext context ,String value) async{
    
    DateTime now = DateTime.parse(DateTime.now().toString().split(" ").first);
    
    if(value == "Today"){
      return now;
    
    }else if(value == "Tomorrow"){
      return now.add( const Duration(days: 1));

    }else{
      DateTime? selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime.utc(2050),
      );
      
      return selectedDate;
    }
  }

}