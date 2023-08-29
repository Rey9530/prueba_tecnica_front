// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/components/component.dart';

class DrowpDownList extends StatefulWidget {
  DrowpDownList({
    super.key,
    required this.items,
    required this.onChanged,
    this.title,
    this.disable = false,
    this.refresh = true,
    this.isInValid = false,
    this.valueSelected = '0',
  });

  List<Map<String, dynamic>> items;
  String? valueSelected;
  String? title;
  bool disable;
  bool refresh;
  bool isInValid;
  final ValueChanged<String> onChanged;
  @override
  State<DrowpDownList> createState() => _DrowpDownListState();
}

class _DrowpDownListState extends State<DrowpDownList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        TextFieldContaiter(
          margin: 1,
          isRed: widget.isInValid,
          childSecond: const SizedBox(),
          child: Column(
            children: [
              const SizedBox(height: 2),
              (widget.title != null)
                  ? SizedBox(
                      width: double.infinity,
                      child: Text(
                        widget.title!,
                        style: TextStyle(
                          color:
                              widget.isInValid ? Colors.red : Colors.deepPurple,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    )
                  : Container(),
              DropdownButtonFormField<String>(
                validator: (String? value) {
                  widget.isInValid = value == '0' ? true : false;
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                borderRadius: BorderRadius.circular(5),
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  fillColor: Colors.deepPurple,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
                value: widget.valueSelected,
                hint: Text((widget.title != null) ? widget.title! : ""),
                items: widget.items.map((Map<String, dynamic> value) {
                  return DropdownMenuItem<String>(
                    value: value['id'],
                    child: SizedBox(
                      child: Text(
                        value['text'],
                        style: TextStyle(
                          color:
                              widget.isInValid ? Colors.red : Colors.deepPurple,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: widget.disable
                    ? null
                    : (valor) {
                        if (valor == '0') {
                          return;
                        }
                        widget.onChanged(valor!);
                        widget.isInValid = valor == '0' ? true : false;
                        widget.valueSelected = valor;
                        setState(() {});
                      },
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        (widget.isInValid)
            ? Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: Text(
                  "${widget.title ?? ""} Es requerido",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.withOpacity(0.8),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
