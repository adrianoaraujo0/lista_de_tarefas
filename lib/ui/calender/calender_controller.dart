import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/menu/menu_controller.dart';
import 'package:lista_de_tarefas/ui/menu/menu_repository.dart';
import 'package:rxdart/subjects.dart';

class CalendarController{

  BehaviorSubject<DateTime> streamCalender = BehaviorSubject<DateTime>();
  BehaviorSubject<List<Todo>> streamTasksCalender = BehaviorSubject<List<Todo>>();
  MenuRepository menuRepository = MenuRepository();

  void filterTasks(DateTime dateTime){
    streamTasksCalender.sink.add(menuRepository.findTasks(DateTime.parse(dateTime.toString().split(" ").toList().first)));
  }  

}