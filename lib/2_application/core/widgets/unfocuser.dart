import 'package:flutter/material.dart';

class Unfocuser extends StatelessWidget {
  final Widget child;

  const Unfocuser({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(),
      child: child,
    );
  }

  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
