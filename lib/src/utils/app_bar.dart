import 'package:flutter/material.dart';

AppBar appBar(context, title) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(title),
  );
}
