import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  const SquareTile({Key? key, required this.imagePath, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[200]
        ),

        child: Image.asset(imagePath,
          height: 80,),
      ),
    );
  }
}
