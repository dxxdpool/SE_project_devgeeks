import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'trapezoid_button.dart';

class ToDoListFun extends StatefulWidget {
  const ToDoListFun({Key? key}) : super(key: key);

  @override
  State<ToDoListFun> createState() => _ToDoListFunState();
}

class _ToDoListFunState extends State<ToDoListFun> {
  final List<String> _items = [];
  final List<bool> _isCheckedList = [];
  final DateTime _currentDateTime = DateTime.now();
  final _prefsKey = 'todo_items';

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getString(_prefsKey);
    if (itemsJson != null) {
      final List<dynamic> decodedJson = jsonDecode(itemsJson);
      final items = decodedJson.cast<String>();
      setState(() {
        _items.addAll(items);
        _isCheckedList.addAll(List<bool>.generate(items.length, (_) => false));
      });
    }
  }

  void _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = jsonEncode(_items);
    prefs.setString(_prefsKey, itemsJson);
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String taskName = '';
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Task Name',
              hintText: 'eg. Buy groceries',
            ),
            onChanged: (value) {
              taskName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _items.add(taskName); // add the new task to the list
                  _isCheckedList.add(false); // set the checked state to false
                  _saveItems(); // save the updated list
                });
                Navigator.of(context).pop(); // close the dialog
              },
              child: const Text('ADD'),
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      _items.removeAt(index);
      _isCheckedList.removeAt(index);
      _saveItems(); // save the updated list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const TrapezoidalAppBar(
        title: "To Do List", color: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Add your Tasks',
                style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),),
            Text(
              DateFormat('EEE, MMM d, yyyy').format(_currentDateTime),
              style: const TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('h:mm a').format(_currentDateTime),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  // your existing ListView.builder code
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isCheckedList[index] ? Colors.lightBlueAccent.withOpacity(0.5) : Colors.white.withOpacity(0.9),
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(
                                  _items[index],
                                  style: TextStyle(
                                    color: _isCheckedList[index] ? Colors.white : Colors.black,
                                    decoration: _isCheckedList[index] ? TextDecoration
                                        .lineThrough : TextDecoration.none,
                                  ),
                                ),
                                value: _isCheckedList[index],
                                onChanged: (bool? isChecked) {
                                  setState(() {
                                    _isCheckedList[index] = isChecked!;
                                  });
                                },
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _deleteTask(index);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // your existing FloatingActionButton code
        onPressed: () {
          _showAddDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


