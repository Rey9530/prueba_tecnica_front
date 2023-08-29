// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  ButtonComponent({
    super.key,
    required this.onPress,
    required this.title,
    this.color = Colors.deepPurple,
  });

  Function()? onPress;
  String title;
  Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: color.withOpacity(0.9),
        ),
        onPressed: onPress,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
