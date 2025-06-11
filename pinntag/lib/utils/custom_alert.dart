import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommonAlertDialog {
  static void showWithOkay({
    String title = 'Pinntag',
    required String content,
    VoidCallback? onOkPressed,
    bool barrierDismissible = false,
    String okText = "OK",
  }) {
    _showIOSAlert(title, content, onOkPressed);
  }

  static void showWithCancelAndOkay({
    String title = 'Pinntag',
    required String content,
    required VoidCallback onOkPressed,
    bool barrierDismissible = false,
    String okText = "OK",
    String cancelText = "Cancel",
  }) {
    _showIOSAlertWithCancel(
      title,
      content,
      onOkPressed,
      okText: okText,
      cancelText: cancelText,
      barrierDismissible: barrierDismissible,
    );
  }

  static void _showIOSAlert(
    String title,
    String content,
    VoidCallback? onOkPressed, {
    String okText = "OK",
  }) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
              onOkPressed?.call();
            },
            child: Text(okText),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void _showIOSAlertWithCancel(
    String title,
    String content,
    VoidCallback onOkPressed, {
    String okText = "OK",
    String cancelText = "Cancel",
    bool barrierDismissible = false,
  }) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Get.back(),
            child: Text(cancelText),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Get.back();
              onOkPressed();
            },
            child: Text(okText),
          ),
        ],
      ),
    );
  }
}
