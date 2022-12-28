import 'package:lista_de_tarefas/database/objectbox_database.dart';
import 'package:lista_de_tarefas/models/todo.dart';

class MenuRepository{

  List<Todo> findAllTasks()=> ObjectBoxDatabase.todoBox.getAll();

  void updateTask(Todo todo) {
    ObjectBoxDatabase.todoBox.put(todo);
  }

}