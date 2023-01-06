
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_de_tarefas/components/drawer_component.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/createTask/create_task_page.dart';
import 'package:lista_de_tarefas/ui/menu/menu_controller.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';
import 'package:lista_de_tarefas/extensions.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  MenuController menuController = MenuController();

  @override
  void initState() {
    menuController.validateUser();
    menuController.updatelistTasks();
    super.initState();
  }

  @override
  void dispose() {
    menuController.deleteTask();
    // menuController.connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: ListColors.white,
          drawer: DrawerComponent(),
          body: StreamBuilder<List<Todo>>(
            initialData: const [],
            stream: menuController.streamTasks.stream,
            builder: (context, snapshot) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.fromLTRB(25, MediaQuery.of(context).padding.top, 25, 55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: const Icon(FontAwesomeIcons.bars, color: ListColors.purple,),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text("Tasks", style: TextStyle(fontSize: 50, color: ListColors.purple)),
                              buildButtonRemove()
                            ],
                          ),
                          const SizedBox(height: 80),
                          buildMenu(snapshot.data!)           
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          buildButtonCreateTask(context)
                        ]
                      ),
                    )
                  ],
                );
            }
          ),
        );
      }
    );
  }

  Widget buildMenu(List<Todo> listTasks){
    return StreamBuilder<String>(
      stream: menuController.streamFilterTasks.stream,
      initialData: "All tasks",
      builder: (context, snapshot) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildButtonFilterTask(snapshot.data!),
              buildListTasks(listTasks, snapshot.data!)   
            ],
          ),
        );
      }
    );
  }

  Widget buildButtonFilterTask(String buttonPressed){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildButtonsRotate("All tasks", buttonPressed),
        buildButtonsRotate("Pending", buttonPressed),
        buildButtonsRotate("Completed", buttonPressed),
      ],
    );
  }

  Widget buildButtonsRotate(String name, String buttonPressed){
    return InkWell(
      onTap: () {
        menuController.streamFilterTasks.sink.add(name);
        menuController.filterTasks(name);
      },
      child: RotatedBox(
        quarterTurns: 3,
        child: Text(name, style: TextStyle(color: name != buttonPressed ? ListColors.grey: ListColors.purple, fontSize: 25, fontWeight: FontWeight.w300,fontFamily: "Arial")
        ),
      ),
    );
  }

  Widget buildListTasks(List<Todo>? listTasks, String buttonPressed){
    return  Expanded(
      child: ListView.builder(
        itemCount: listTasks!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return buildTask(listTasks[index], buttonPressed);
        },
      ),
    );     
  }

  Widget buildTask(Todo task, String buttonPressed){
    return InkWell(
      onTap: () => menuController.updateTask(task, buttonPressed),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 0, 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                "${task.title}", 
                style: TextStyle(
                  fontSize: 25,
                  decoration: task.itsDone == null || task.itsDone == false
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
                  decorationColor: ListColors.purple,
                  decorationStyle: TextDecorationStyle.solid
                )
              ),
            ),
            Text(
              "${task.dateTime!.day.padLeft}/${task.dateTime!.month.padLeft}/${task.dateTime!.year}",
              style: TextStyle(
                decoration: task.itsDone == null || task.itsDone == false
                ? TextDecoration.none
                : TextDecoration.lineThrough,
                decorationColor: ListColors.purple,
                decorationStyle: TextDecorationStyle.solid
              )
            )
          ],
        ),
      ),
    );
  }

   buildButtonRemove(){
    return StreamBuilder<bool>(
      stream: menuController.streamIconDeleteTasks.stream,
      builder: (context, snapshot) {
        return IconButton(
          onPressed: () => menuController.deleteTask(),
          icon: Icon(
            Icons.delete,
            color: snapshot.data == null || snapshot.data! == false 
            ? ListColors.grey
            : ListColors.purpleDark
          )
        );
      }, 
    );
  }

  Widget buildButtonCreateTask(BuildContext context){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskPage(menuController: menuController))),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(65)),
          color: ListColors.purple,
        ),
        height: 70,
        width: 120,
        child: Center(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: ListColors.purpleDark),
            child: const Icon(Icons.add, color: ListColors.white),
          ),
        ),
      ),
    );
  }

}