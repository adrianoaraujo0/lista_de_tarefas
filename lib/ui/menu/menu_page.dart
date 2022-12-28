
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
    menuController.listTasks();
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ListColors.white,
      body: StreamBuilder<List<Todo>>(
        stream: menuController.streamTasks.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
          print(snapshot.data!.length);
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
                      const Text("Tasks", style: TextStyle(fontSize: 50, color: ListColors.purple)),
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
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () => menuController.updateTask(snapshot.data![index]),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(25, 0, 0, 40),
                                      child: Text(
                                        "${snapshot.data![index].title}", 
                                        style: TextStyle(
                                          fontSize: 26,
                                          decoration: snapshot.data![index].itsDone ? TextDecoration.lineThrough : TextDecoration.none,
                                          decorationColor: ListColors.purple,
                                          decorationStyle: TextDecorationStyle.solid
                                        )
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )       
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

  Widget buildButtonCreateTask(BuildContext context){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTaskPage())),
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
            child: const Icon(Icons.add, color: ListColors.white,),
          ),
        ),
      ),
    );
  }

  Widget buildListToDo(){
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container();
      },
    );
  }
}