import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/createTask/create_task_controller.dart';
import 'package:lista_de_tarefas/ui/menu/menu_controller.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';

// ignore: must_be_immutable
class CreateTaskPage extends StatefulWidget {
  CreateTaskPage({required this.menuController ,Key? key}) : super(key: key);
  MenuController menuController;


  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final CreateTaskController createTaskController = CreateTaskController();
   
  @override
  void initState() {
    createTaskController.streamTodo.sink.add(Todo());
    super.initState();
  }

  @override
  void dispose() {
    widget.menuController.updatelistTasks();
    createTaskController.streamTodo.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: ListColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ListColors.purple),
          onPressed: ()=> Navigator.pop(context)
        ),
        elevation: 0,
        backgroundColor: ListColors.white,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<Todo>(
          stream: createTaskController.streamTodo.stream,
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.only(top: 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 87,
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
                          Form(
                            key: createTaskController.formKey,
                            child: TextFormField(
                              cursorHeight: 40,
                              style: const TextStyle(fontSize: 40),
                              controller: createTaskController.taskController,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Add task";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(hintText: "Enter Task", hintStyle: TextStyle(fontSize: 50, color: Colors.grey)),
                            ),
                          ),
                          const SizedBox(height: 80),
                          const Text("W H E N", style: TextStyle(color: ListColors.black, fontWeight: FontWeight.w400, fontSize: 20, fontFamily: "Times-new-roman")),
                          const SizedBox(height: 60),
                          buildselectDay(context, snapshot.data),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      createTaskController.addTask(context, snapshot.data);
                    },
                    child: Container(
                      height: 100,
                      color: ListColors.purple,
                      child: const Center(child:  Text("Add Task", style: TextStyle(color: ListColors.white, fontSize: 30))),
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget buildselectDay(BuildContext context, Todo? todo){
    return StreamBuilder<String>(
      stream: createTaskController.streamSelectDate.stream,
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(context ,"Today", snapshot.data),
            const SizedBox(width: 40),
            buildButton(context ,"Tomorrow", snapshot.data),
            const SizedBox(width: 40),
            buildButton(context ,"Select Date", snapshot.data),
          ],
        );
      }
    );
  }

  Widget buildButton(BuildContext context ,String name, String? isSelected){
    return InkWell(
      onTap: () async {
        DateTime? date = await createTaskController.pickDate(context, name);
        createTaskController.streamTodo.sink.add(Todo(dateTime: date));
        createTaskController.streamSelectDate.sink.add(name);
      },
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
