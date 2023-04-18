import 'package:flutter/material.dart';

class MyButtonTask extends StatelessWidget {

  final Function()? onTap;
  final String text;

  const MyButtonTask({Key? key, required this.onTap, required this.text}) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10)),

        child: Center(
          child: Text(text,
            style: const TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16),),
        ),
      ),
    );
  }
}
