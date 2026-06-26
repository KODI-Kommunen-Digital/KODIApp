import 'package:flutter/material.dart';

class LoadingDialog {
  static bool _isLoading = false;

  void show(BuildContext context, [String? message]) {
    if (_isLoading) return;

    _isLoading = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true, // This is correct
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false, // Prevent back button from dismissing
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        message,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void hide(BuildContext context) {
    if (!_isLoading) return;

    _isLoading = false;

    try {
      Navigator.of(context, rootNavigator: true).pop();
    } catch (_) {
    }
  }
}