import 'package:flutter/material.dart';

class LoadingDialog {
  BuildContext? ctx;
  static bool _isLoading = false;

  show(BuildContext context, [String? message]) {
    if (!_isLoading) {
      _isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          ctx = context;
          return PopScope(
            canPop: false,
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
      ).then((_) {
        ctx = null;
        _isLoading = false;
      });
    }
  }

  hide() {
    if (_isLoading && ctx != null) {
      try {
        // Try-catch to handle cases where the context is no longer valid
        if (Navigator.canPop(ctx!)) {
          Navigator.of(ctx!).pop();
        }
      } catch (e) {
        // If there's an error popping, just update the flag
        print('Error hiding loading dialog: $e');
      } finally {
        _isLoading = false;
        ctx = null;
      }
    }
  }
}
