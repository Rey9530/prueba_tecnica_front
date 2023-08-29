import 'package:flutter/material.dart';

class TextFieldContaiter extends StatelessWidget {
  const TextFieldContaiter({
    Key? key,
    required this.child,
    required this.childSecond,
    this.isTextArea = false,
    this.isRed = false,
    this.height = 55,
    this.margin = 5,
    this.circular = 5,
  }) : super(key: key);

  final Widget child;
  final Widget childSecond;
  final bool isTextArea;
  final bool isRed;
  final double margin;
  final double circular;
  final double height;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      width: size.width,
      height: isTextArea ? null : height,
      decoration: BoxDecoration(
        color:
            isRed ? Colors.red.withOpacity(0.1) : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(circular),
        border: Border.all(
          color: isRed ? Colors.red : Colors.transparent,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [Expanded(child: child), childSecond],
      ),
    );
  }
}
