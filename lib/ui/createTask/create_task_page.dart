import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/createTask/create_task_controller.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';

class CreateTaskPage extends StatelessWidget {
  CreateTaskPage({Key? key}) : super(key: key);

  final CreateTaskController createTaskController = CreateTaskController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Add new", style: TextStyle(color: ListColors.purple, fontSize: 55)), 
                      const SizedBox(height: 150),
                      TextField(
                        controller: createTaskController.taskController,
                        decoration: const InputDecoration(hintText: "Enter Task", hintStyle: TextStyle(fontSize: 50, color: Colors.grey)),
                      ),
                      const SizedBox(height: 80),
                      const Text("W H E N", style: TextStyle(color: ListColors.black, fontWeight: FontWeight.w400, fontSize: 20, fontFamily: "Times-new-roman")),
                      const SizedBox(height: 60),
                      buildselectDay(),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              InkWell(
                // onTap: () => ,
                child: Container(
                  height: 100,
                  color: ListColors.purple,
                  child: const Center(child:  Text("Add Task", style: TextStyle(color: ListColors.white, fontSize: 30))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildselectDay(){
    return StreamBuilder<String>(
      stream: createTaskController.streamSelectDate.stream,
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton("Today", snapshot.data),
            const SizedBox(width: 40),
            buildButton("Tomorrow", snapshot.data),
            const SizedBox(width: 40),
            buildButton("Select Date", snapshot.data),
          ],
        );
      }
    );
  }

  Widget buildButton(String name, String? isSelected){
    return InkWell(
      onTap: () => createTaskController.streamSelectDate.sink.add(name),
      child: Text(
        name,
        style: TextStyle(
          color: name == isSelected  
           ? ListColors.purple
           : ListColors.grey,
          fontSize: 17
        )
      ),
    );
  }
}
