import 'package:flutter/material.dart';

void showAlertDiologe(
    {required BuildContext context,
    required String tittle,
    required String content}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(tittle),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}
