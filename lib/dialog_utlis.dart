import 'package:flutter/material.dart';

class DialogUtlis {
  static void showLoading(BuildContext context, String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 10,
                ),
                Text(message),
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context, String message,
      {String title = 'Title',
      String? posActionName,
      VoidCallback? posAction,
      String? negActionName,
      VoidCallback? negAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName)));
    }
    if (negActionName != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(negActionName)));
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            title: Text(title),
            actions: actions,
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
          );
        });
  }
}
