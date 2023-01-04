import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/calender/calender_page.dart';
import 'package:lista_de_tarefas/ui/menu/menu_controller.dart';
import 'package:lista_de_tarefas/utils/list_colors.dart';

class DrawerComponent extends StatelessWidget {
  DrawerComponent({super.key});
  final MenuController menuController = MenuController();


  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: ListColors.purple,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 const Text("TO DO APP", style: TextStyle(color: ListColors.white, fontSize: 20)),
                 InkWell( onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: ListColors.white, size: 25)),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.06),
                      buildText(context: context, title: "Calender", route: CalenderPage()),
                      SizedBox(height: MediaQuery.of(context).size.height*0.04),
                      buildText(context: context, title: "Settings"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.06),
                      buildText(context: context, title: "About", isSettings: true),
                      SizedBox(height: MediaQuery.of(context).size.height*0.04),
                      buildText(context: context, title: "Private Policy", isSettings: true),
                      SizedBox(height: MediaQuery.of(context).size.height*0.04),
                      buildText(context: context, title:"License", isSettings: true),
                      SizedBox(height: MediaQuery.of(context).size.height*0.04),
                      InkWell(
                        onTap: () =>  menuController.signOut(context),
                        child: const Icon(Icons.logout, color: ListColors.white, size: 30)
                      ),
                    ],
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText({required BuildContext context, dynamic route, required String title, bool isSettings = false}){
    return InkWell(
      onTap: route != null
      ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => route))
      : (){},
      child: Text(title, style: TextStyle(color: ListColors.white, fontSize: isSettings ? 20 : 35)),
    );
  }


}