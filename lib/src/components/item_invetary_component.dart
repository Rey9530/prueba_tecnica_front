// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/pages/pages.dart';

class ItemInventaryWidget extends StatelessWidget {
  ItemInventaryWidget({
    super.key,
    required this.item,
  });
  var item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        // border: Border.all(width: 0.5, color: Colors.black38),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            // offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(0),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormDescInvPage(item: item),
            ),
          );
        },
        child: Row(
          children: [
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["nombre"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Existencia: ${item["cantidad_en_existencia"]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Icon(Icons.arrow_forward_ios),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
