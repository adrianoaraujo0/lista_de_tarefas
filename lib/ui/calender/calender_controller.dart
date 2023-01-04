import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/menu/menu_controller.dart';
import 'package:lista_de_tarefas/ui/menu/menu_repository.dart';
import 'package:rxdart/subjects.dart';

class CalendarController{

  BehaviorSubject<DateTime> streamCalender = BehaviorSubject<DateTime>();
  BehaviorSubject<List<Todo>> streamTasksCalender = BehaviorSubject<List<Todo>>();
  MenuRepository menuRepository = MenuRepository();

  void initPage(){
    String now = DateTime.now().toString().split(" ").first;
    streamTasksCalender.sink.add(menuRepository.findTasks(DateTime.parse(now)));
  }

  void filterTasks(DateTime dateTime){
    print(menuRepository.findTasks(DateTime.parse(dateTime.toString().split(" ").toList().first)));
    streamTasksCalender.sink.add(menuRepository.findTasks(DateTime.parse(dateTime.toString().split(" ").toList().first)));
  }  

  List<DateTime?> getTaskDates() {
    return menuRepository.findAllTasks().map((e) => e.dateTime).toList();
  }
}