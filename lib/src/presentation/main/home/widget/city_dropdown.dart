import 'dart:io';
import 'package:flutter/material.dart';

class CitiesDropDown extends StatelessWidget {
  final String? displayText;

  const CitiesDropDown({
    super.key,
    this.displayText,
  });

  @override
  Widget build(BuildContext context) {
    EdgeInsets contentPadding = Platform.isIOS
        ? const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0)
        : const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 16, bottom: 8),
        child: Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
                color: Colors.white, width: 1.0), // Added white border
          ),
          elevation: 2,
          child: Container(
            padding: contentPadding,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              displayText ?? 'Default Text',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
