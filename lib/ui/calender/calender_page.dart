import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/calender/calender_controller.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lista_de_tarefas/extensions.dart';

class CalenderPage extends StatefulWidget {
  CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  CalendarController calendarController = CalendarController();

  @override
  void initState() {
    calendarController.initPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ListColors.white,
        appBar: AppBar(backgroundColor: ListColors.white,elevation: 0, iconTheme: const IconThemeData(color: ListColors.purple)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: StreamBuilder<DateTime>(
            stream: calendarController.streamCalender.stream,
            initialData: DateTime.now(),
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Calender", style: TextStyle(color: ListColors.purple, fontSize: 40)),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  buildCalender(snapshot.data!),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  buildListTasks(context, snapshot.data!)
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  buildCalender(DateTime dateTimeSelected){
    return TableCalendar(
      calendarStyle: const CalendarStyle(
        weekendTextStyle: TextStyle(color: Colors.red),
        todayDecoration: BoxDecoration(color: ListColors.purple,shape: BoxShape.circle),
        holidayDecoration: BoxDecoration(border: Border.fromBorderSide(BorderSide(color: Color.fromARGB(255, 207, 184, 235), width: 1.4)), shape: BoxShape.circle, color: Color.fromARGB(255, 192, 176, 213)),
        
      ),
      headerStyle: const HeaderStyle(titleCentered: true, formatButtonVisible: false),
      currentDay: dateTimeSelected,
      focusedDay: dateTimeSelected,
      holidayPredicate: (day) {
          DateTime onlyDate = DateTime.parse(day.toString().split(" ").first);
          return calendarController.getTaskDates().contains(onlyDate);
      },
      
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2050),
      onDaySelected: (selectedDay, focusedDay) {
        calendarController.streamCalender.sink.add(selectedDay);
        calendarController.filterTasks(selectedDay);
      },
    );
  }

  buildListTasks(BuildContext context, DateTime dateTime){
    return StreamBuilder<List<Todo>>(
      stream: calendarController.streamTasksCalender.stream,
      initialData: const [],
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    style: const TextStyle(fontSize: 20),
                    dateTime.toString().split(" ").first == DateTime.now().toString().split(" ").first
                    ? "Today - ${snapshot.data!.length} Task(s)"
                    : "${dateTime.day.padLeft}/${dateTime.month.padLeft}/${dateTime.year} - ${snapshot.data!.length} Task(s)",
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return buildTask(snapshot.data![index]);
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      }
    );
  }

  buildTask(Todo todo){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(todo.title!, style: const TextStyle(fontSize: 30)),
    );
  }
}