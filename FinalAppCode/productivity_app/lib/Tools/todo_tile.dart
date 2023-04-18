import 'package:flutter/material.dart';

class ToDoTileFun extends StatelessWidget {

  final String taskName;
  final bool taskComplete;
  Function(bool?)? onChanged;
  ToDoTileFun({Key? key,
    required this.taskName,
    required this.taskComplete,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(35.0),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Checkbox(value: taskComplete, onChanged: onChanged),
            const SizedBox(width: 15,),
            Text(taskName,
            style: const TextStyle(
              fontSize: 20,
            ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}
