import 'package:flutter/material.dart';
import 'package:todoapp/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;


  DialogBox({
    super.key, // Fix the Key parameter here
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }); // Make sure to call the super constructor with the key parameter

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return AlertDialog(
      backgroundColor:Colors.blue ,
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 120,
        // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
        child: Column(children: [
          // get user input
            // ignore: prefer_const_constructors
            TextField(
              controller: controller,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                // ignore: prefer_const_constructors
                border: OutlineInputBorder(),
                hintText: "Add Text",
                ),
            ),


            // buttons -> save + cancel
            // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              // save button
              MyButton(text: "save", onPressed: onSave),

              const SizedBox(width: 8,),


              // cancel button
               MyButton(text: "cancel", onPressed: onCancel),

            ],)
        ],),
      ),
    );
  }
}