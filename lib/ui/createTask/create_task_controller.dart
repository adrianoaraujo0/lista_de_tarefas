import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/createTask/create_task_repository.dart';
import 'package:rxdart/subjects.dart';

class CreateTaskController{

  TextEditingController taskController = TextEditingController();
  BehaviorSubject<String> streamSelectDate = BehaviorSubject<String>();
  BehaviorSubject<Todo> streamTodo = BehaviorSubject<Todo>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  CreateTaskRepository createTaskRepository = CreateTaskRepository();

  void addTask(BuildContext context ,Todo? todo){
    formKey.currentState!.validate();
    validateDate(context, todo);


    if(formKey.currentState!.validate() && validateDate(context, todo)){
      todo!.title = taskController.text;

      createTaskRepository.addTask(todo);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saved task"))
      );
    }

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

    DateTime date = DateTime.now();

    if(value == "Today"){
      return date;
    
    }else if(value == "Tomorrow"){
      return date.add( const Duration(days: 1));

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