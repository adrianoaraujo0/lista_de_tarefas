import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class CreateTaskController{

  TextEditingController taskController = TextEditingController();

  BehaviorSubject<String> streamSelectDate = BehaviorSubject<String>();

}