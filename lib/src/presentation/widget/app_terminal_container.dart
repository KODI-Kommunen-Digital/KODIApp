import 'package:flutter/material.dart';

class AppTerminalContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? round;
  final String? title;
  final List<Widget>? widgets;

  const AppTerminalContainer({
    super.key,
    this.height,
    this.width,
    this.round,
    this.title,
    this.widgets
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: ((round ?? false) == true)
            ? BorderRadius.circular(20)
            : BorderRadius.zero,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 32),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(2),
              child: Text(title!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          ...?widgets
        ],
      ),
    );
  }
}
