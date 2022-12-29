import 'package:lista_de_tarefas/database/objectbox_database.dart';
import 'package:lista_de_tarefas/models/todo.dart';

class CreateTaskRepository{

  void addTask(Todo todo){
    ObjectBoxDatabase.todoBox.put(todo);
  }


}