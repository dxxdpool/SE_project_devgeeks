import 'package:flutter/material.dart';
import 'package:productivity_app/Tools/todo_tile.dart';

class ToDoListFun extends StatefulWidget {
  const ToDoListFun({Key? key}) : super(key: key);

  @override
  State<ToDoListFun> createState() => _ToDoListFunState();
}

class _ToDoListFunState extends State<ToDoListFun> {
  List toDoList = [
    ["Task 01", false],
    ["Task 02", false],
    ["Task 03", false],
    ["Task 04", false],
  ];

  // check box on tapped
  void checkBoxChanged (bool? value, int index)
  {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('To Do List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index)
        {
          return ToDoTileFun(taskName: toDoList[index][0],
              taskComplete: toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
