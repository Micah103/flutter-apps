import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }


  // text controller
  final _controller = TextEditingController();


  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task 
  void saveTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // Create New Task
  void createTask() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        // ignore: prefer_const_constructors
        backgroundColor: Colors.blue[600],title: Text(
          'TO DO',
          textAlign: TextAlign.center,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        // ignore: prefer_const_constructors
        child: Icon(
          Icons.add,
          ),
      ),
      body: ListView.builder(
       itemCount: db.toDoList.length,
       itemBuilder: (context, index) {
        return ToDoTile(
          taskName: db.toDoList[index][0], 
          taskCompleted: db.toDoList[index][1], 
          onChanged: (value) => checkBoxChanged(value, index), 
          deletefunction: (context) => deleteTask(index),
          );
       },
      ),
    );
  }
}