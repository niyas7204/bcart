import 'package:flutter/material.dart';

void showSnakbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void showConfirmation(
    {required String title,
    required String body,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
    required BuildContext context}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(child: Text(title)),
      content: Text(
        body,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
            ElevatedButton(onPressed: onConfirm, child: Text("Confirm"))
          ],
        ),
      ],
    ),
  );
}
