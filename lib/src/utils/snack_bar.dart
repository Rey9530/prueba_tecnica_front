// ignore_for_file: empty_catches

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

showSnackbar({title, messaje, ContentType? type, context}) async {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: messaje,
      contentType: type ?? ContentType.warning,
      // inMaterialBanner: true,
    ),
    duration: const Duration(seconds: 4),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  await Future.delayed(const Duration(milliseconds: 4000));
  try {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).clearSnackBars();
  } catch (e) {}
}
