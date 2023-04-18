import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/focus_study.dart';
import 'package:productivity_app/main_ui_page.dart';
import 'package:productivity_app/reminders.dart';
import 'package:productivity_app/resources.dart';
import 'package:productivity_app/new_to_do_list.dart';
import 'package:productivity_app/screens/home.dart';
import 'trapezoid_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;

  // User sign-out method
  void signOutUser(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const TrapezoidalAppBar(
          title: 'Welcome to Clear Dally', color: Colors.blue,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Center(
            child: Column(
              children: [
                const SizedBox(height: 150,),
                // To do list
                MyButtonTask(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const ToDoListFun()));
                    }
                    , text: 'To Do List'),
                const SizedBox(height: 50,),
                // Focus Study
                MyButtonTask(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const PomodoroTimer()));
                    }
                    , text: 'Focus Study'
                ),
                const SizedBox(height: 50,),
                // Resources
                MyButtonTask(onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const ResourceHomePage()));
                }, text: 'Resources'),
                const SizedBox(height: 50,),
                // Reminders
                MyButtonTask(onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ExampleAlarmHomeScreen()));
                }, text: 'Smart Alarm'),
                const SizedBox(height: 50,),
              ],
            ),
      ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: (){
                      signOutUser();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ],

        ),

      )
    );
  }
}
