import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/calender/calender_controller.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatelessWidget {
  CalenderPage({super.key});

  CalendarController calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ListColors.white,
        appBar: AppBar(backgroundColor: ListColors.white,elevation: 0, iconTheme: const IconThemeData(color: ListColors.purple)),
        body: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Calender", style: TextStyle(color: ListColors.purple, fontSize: 40)),
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
              buildStreamBuildCalender(),
              buildListTasks()
            ],
          ),
        ),
      ),
    );
  }

  buildStreamBuildCalender(){
    return StreamBuilder<DateTime>(
      stream: calendarController.streamCalender.stream,
      initialData: DateTime.now(),
      builder: (context, snapshot) {
        return buildCalender(snapshot.data!);
      }
    );
  }

  buildCalender(DateTime dateTime){
    return  TableCalendar(
      calendarStyle: const CalendarStyle(
        weekendTextStyle: TextStyle(color: Colors.red),
        todayDecoration: BoxDecoration(color: ListColors.purple,shape: BoxShape.circle),
      ),
      headerStyle: const HeaderStyle(titleCentered: true, formatButtonVisible: false),
      currentDay: dateTime,
      focusedDay: dateTime,
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2050),
      onDaySelected: (selectedDay, focusedDay) {
        calendarController.streamCalender.sink.add(selectedDay);
        calendarController.filterTasks(dateTime);
      },
    );
  }

  buildListTasks(){
    return StreamBuilder<List<Todo>>(
      stream: calendarController.streamTasksCalender.stream,
      initialData: const [],
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Text(snapshot.data![index].title!);
              },
            ),
          );
        }else{
          return Container();
        }
      }
    );
  }


}