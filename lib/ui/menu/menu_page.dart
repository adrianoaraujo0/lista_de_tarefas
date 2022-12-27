
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lista_de_tarefas/ui/createTask/create_task_page.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ListColors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25,35,25,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Icon(FontAwesomeIcons.bars,  color: ListColors.lightBlack, size: 30),
                  ),
                  const SizedBox(height: 30),
                  const Text("Tasks", style: TextStyle(fontSize: 50, color: ListColors.purple)),
                  const SizedBox(height: 120),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildButtonsRotate("Today"),
                          const SizedBox(height: 100),
                          buildButtonsRotate("Tomorrow"),
                          const SizedBox(height: 100),
                          buildButtonsRotate("Last Week"),
                        ],
                      ),
                    ],
                  ),
                ]
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
        ),
      ),
    );
  }

  Widget buildButtonsRotate(String name){
    return RotatedBox(
      quarterTurns: 3,
      child: Text(name, style: const TextStyle(color: ListColors.purple, fontSize: 25, fontWeight: FontWeight.w300, fontFamily: "Arial")
      ),
    );
  }

  Widget buildButtonCreateTask(BuildContext context){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskPage())),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(65)),
          color: ListColors.purple,
        ),
        height: 100,
        width: 120,
        child: Center(
          child: Container(
            height: 50,
            width: 50,
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