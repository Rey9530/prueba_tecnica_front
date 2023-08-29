// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/components/component.dart';

class RoundedInputField extends StatefulWidget {
  RoundedInputField({
    super.key,
    required this.hinText,
    this.title,
    this.formatString,
    this.tooltip,
    this.example,
    this.isEmail = false,
    this.readOnly = false,
    this.isRequired = false,
    this.isTextArea = false,
    this.isonlyAfaNumber = false,
    this.maskFormatter,
    this.onChanged,
    this.widgetSufix,
    this.controller,
    this.preIcon,
    this.marginTop = 10,
    this.marginVertical = 5,
    this.height = 55,
    this.maxLength = 250,
    this.icon = Icons.person,
    this.isInValid = false,
    this.keyboardType = TextInputType.text,
  });

  final String hinText;
  final bool isEmail;
  final bool readOnly;
  final bool isRequired;
  final bool isTextArea;
  final bool isonlyAfaNumber;
  final dynamic maskFormatter;
  final Widget? widgetSufix;
  final TextInputType keyboardType;
  final String? title;
  final String? formatString;
  final String? tooltip;
  final String? example;
  final IconData icon;
  final IconData? preIcon;
  final int maxLength;
  final double marginTop;
  final double marginVertical;
  final double height;
  final ValueChanged<String>? onChanged;
  TextEditingController? controller;
  final bool isInValid;

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  String hinTextLocal = "";

  bool isEmailValid = false;
  bool isInValid = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: widget.marginTop),
        TextFieldContaiter(
          height: widget.height,
          isTextArea: widget.isTextArea,
          margin: widget.marginVertical,
          childSecond:
              (widget.widgetSufix != null) ? widget.widgetSufix! : Container(),
          isRed: (isInValid || widget.isInValid),
          child: TextFormField(
            keyboardType: widget.keyboardType,
            readOnly: widget.readOnly,
            maxLines: (widget.isTextArea) ? 4 : 1,
            validator: (value) {
              if (widget.controller != null) {
                isInValid = widget.controller!.text.isEmpty ? true : false;
                setState(() {});
              }
              return null;
            },
            onChanged: (value) {
              if (widget.controller != null) {
                isInValid = widget.controller!.text.isEmpty ? true : false;
                setState(() {});
              }
              setState(() {});
            },
            controller: widget.controller,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: widget.formatString,
              labelText: "${widget.title ?? ""} *",
              labelStyle: TextStyle(
                color: (isInValid || widget.isInValid)
                    ? Colors.red
                    : Colors.deepPurple,
              ),
              hintStyle: TextStyle(
                color: (isInValid || widget.isInValid)
                    ? Colors.red
                    : Colors.deepPurple,
              ),
              border: InputBorder.none,
              errorStyle: const TextStyle(
                fontSize: 16.0,
              ),
              contentPadding: const EdgeInsets.only(top: 2, bottom: 2),
            ),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
