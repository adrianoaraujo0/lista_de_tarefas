
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_de_tarefas/models/todo.dart';
import 'package:lista_de_tarefas/ui/createTask/create_task_page.dart';
import 'package:lista_de_tarefas/ui/menu/menu_controller.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  MenuController menuController = MenuController();

  @override
  void initState() {
    menuController.updatelistTasks();
    super.initState();
  }

  @override
  void dispose() {
    menuController.deleteTask();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListColors.white,
      body: StreamBuilder<List<Todo>>(
        stream: menuController.streamTasks.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.fromLTRB(25, MediaQuery.of(context).padding.top + 25, 25, 55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(FontAwesomeIcons.bars,  color: ListColors.lightBlack, size: 30),
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
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                buildButtonsRotate("Today", strong: true),
                                const SizedBox(height: 100),
                                buildButtonsRotate("Tomorrow"),
                                const SizedBox(height: 100),
                                buildButtonsRotate("Last Week"),
                              ],
                            ),
                            buildListTasks(snapshot.data)   
                          ],
                        ),
                      )             
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
          return Container();
        }
      ),
    );
  }

  Widget buildButtonsRotate(String name, {bool strong = false}){
    return RotatedBox(
      quarterTurns: 3,
      child: Text(name, style: TextStyle(color: ListColors.purple, fontSize: 25, fontWeight: strong ? FontWeight.bold : FontWeight.w300, fontFamily: "Arial")
      ),
    );
  }

  Widget buildListTasks(List<Todo>? listTasks){
    return  Expanded(
      child: ListView.builder(
        itemCount: listTasks!.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => menuController.updateTask(listTasks[index]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 40),
              child: Text(
                "${listTasks[index].title}", 
                style: TextStyle(
                  fontSize: 26,
                  decoration: listTasks[index].itsDone == null || listTasks[index].itsDone == false
                  ? TextDecoration.none
                  : TextDecoration.lineThrough,
                  decorationColor: ListColors.purple,
                  decorationStyle: TextDecorationStyle.solid
                )
              ),
            ),
          );
        },
      ),
    );     
  }

  Widget buildTask(Todo task){
    return InkWell(
      onTap: () => menuController.updateTask(task),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 0, 40),
        child: Text(
          "${task.title}", 
          style: TextStyle(
            fontSize: 26,
            decoration: task.itsDone == null || task.itsDone == false
            ? TextDecoration.none
            : TextDecoration.lineThrough,
            decorationColor: ListColors.purple,
            decorationStyle: TextDecorationStyle.solid
          )
        ),
      ),
    );
  }

   buildButtonRemove(){
    return StreamBuilder<bool>(
      stream: menuController.streamDeleteTasks.stream,
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